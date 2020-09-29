//
//  SPAPIServices.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Alamofire
import OHHTTPStubs
struct APIConstants {
    static let baseURL = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/"
    static let hostHeader = "apidojo-yahoo-finance-v1.p.rapidapi.com"
    static let apiKey =  "1862897498" // This is not the actual API key
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

public class APIRouter: APIConfiguration {

    let method: HTTPMethod = .get
    var path: String {
        return ""
    }

    var parameters: Parameters?

    init(_ params: Parameters? = nil ) {
        parameters = params
    }

    public func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL()
        return try createRequest(from: url)
    }

    public func createRequest(from url: URL) throws -> URLRequest {
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        request.setValue(APIConstants.hostHeader, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

class SPAPIService: NSObject {

    static func request(_ request: URLRequestConvertible, success:@escaping (Data) -> Void, failure:@escaping (SPError) -> Void) {
        #if DEBUG
        let sample = try? request.asURLRequest()
        print("Response for \(String(describing: sample?.url))")
        if let test = sample?.httpBody, let params = String.init(data: test, encoding: .utf8) {
            print("Params \(params)")
        }
        #endif
        //Response data is used as we don't want to parse data twice. i.e. once in Alamofire and one in codable class.
        AF.request(request).responseData { (responseObject) in
            if let data = responseObject.data, let _ = responseObject.value {
                #if DEBUG
                    let json = String(decoding: data, as: UTF8.self)
                    print(json.debugDescription)
                    #endif
                success(data)
            } else if let error = responseObject.error {
                var item: SPError
                if let result = error as NSError? {
                    //Known error
                    item = SPServiceError.init(error: result)
                } else {
                    item = SPServiceError.init(errorCode: SPServiceError.ErrorCode.unknownError)
                }
                failure(item)
            }
        }
    }
}
extension SPAPIService {
    
    static func matcher(request: URLRequest) -> Bool {
        let target = APIConstants.baseURL.replacingOccurrences(of: "https:", with: "").replacingOccurrences(of: "/", with: "")
        return request.url?.host == target  // Let's match this request
    }
    static func provider(request: URLRequest) -> HTTPStubsResponse {
        // Stub it with your stub file (which is in same bundle as self)
        var fileName = ""
        if let requestPath = request.url?.path, let name = requestPath.components(separatedBy: "/").last {
            fileName = "\(name).json"
        }
        let stubPath = OHPathForFile(fileName, type(of: self))
        return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
}
