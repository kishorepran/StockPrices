//
//  StocksDataManager.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

//MARK:- Route
///Keep adding routes here as we add more endpoints
enum SPStocksQuoteRoute: String {
    case getQuotes = "market/v2/get-quotes"
}

public class SPStocksQuoteRouter: APIRouter {
    let route: SPStocksQuoteRoute
    init(_ params: [String: Any]? = nil, route: SPStocksQuoteRoute) {
        self.route = route
        super.init(params)
    }
    override var path: String {
        return route.rawValue
    }
}

class StocksDataManager {
    
    static let shared = StocksDataManager()
    private init() {
    }
    
    public func getQuotes(for stockList: [String], success:@escaping (Data) -> Void, failure:@escaping (SPError) -> Void) {
        let list = stockList.reduce(into: String()) { (newString, element) in
            newString += "\(element),"
        }
        let params = ["region": "US", "symbols": list]
        let router = SPStocksQuoteRouter(params, route: .getQuotes)
        SPAPIService.request(router, success: success, failure: failure)
    }
}
