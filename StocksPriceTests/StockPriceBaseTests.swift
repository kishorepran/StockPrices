//
//  StockPriceBaseTests.swift
//  StocksPriceTests
//
//  Created by Pran Kishore on 24.10.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import StocksPrice

class StockPriceBaseTests: XCTestCase {
    var promise: XCTestExpectation!
    var expectedError: String?
    var errorFile: String?
    override func setUp() {}
    override func tearDown() {
        HTTPStubs.removeAllStubs()
        errorFile = nil
        expectedError = nil
    }
    func matcher(request: URLRequest) -> Bool {
        let target = APIConstants.baseURL.replacingOccurrences(of: "https:", with: "").replacingOccurrences(of: "/", with: "")
        return request.url?.host == target  // Let's match this request
    }
    func provider(request: URLRequest) -> HTTPStubsResponse {
        // Stub it with your stub file (which is in same bundle as self)
        var fileName = ""
        if let requestPath = request.url?.path, let name = requestPath.components(separatedBy: "/").last {
            fileName = "\(name).json"
        }
        let stubPath = OHPathForFileInBundle(fileName, Bundle.main)
        return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
    func errorProvider(request: URLRequest) -> HTTPStubsResponse {
        guard var fileName = errorFile else {
            fatalError()
        }
        fileName = "\(fileName).json"
        let stubPath = OHPathForFile(fileName, type(of: self))
        return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
}
