//
//  StockQuoteModel.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

enum ChangeFormat: String, CaseIterable {
    case percent
    case value
}
// MARK: - StockQuote
struct StockQuote: Codable {
    let quoteResponse: QuoteResponse
}

// MARK: - QuoteResponse
struct QuoteResponse: Codable {
    let result: [Stock]
}

// MARK: - Stock
struct Stock: Codable {
    let preMarketChangePercent, preMarketChange: Double
    let regularMarketPrice, regularMarketChange, regularMarketChangePercent: Double
    let symbol, shortName, longName: String
    var price: String {
        return "\(regularMarketPrice)"
    }
    var valueChange: String {
        return "\(regularMarketChange)"
    }
    var percentChange: String {
        return "\(regularMarketChangePercent)"
    }
    var postValueChange: String {
        return "\(preMarketChange)"
    }
    var postPercentChange: String {
        return "\(preMarketChangePercent)"
    }
}
