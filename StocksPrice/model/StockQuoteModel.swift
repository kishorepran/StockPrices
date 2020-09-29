//
//  StockQuoteModel.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

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
}
