//
//  SPViewModel.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

class SPViewModel: SPBaseViewModel {
    private let dataManager = StocksDataManager.shared
    var selectedChangeFormat = ChangeFormat.percent // Default to percent
    var listStock: [Stock]? {
        didSet {
            delegate?.viewModelDidUpdate(sender: self)
        }
    }
    // MARK: - API CAll
    func fetchQuotes() {
        let quotes = ["APPS", "DOYU", "EXPI", "ICLK", "NIO", "PLUG", "AAPL", "MSFT", "NFLX", "FB", "AMZN", "GOOG"]
        dataManager.getQuotes(for: quotes, success: { (data) in
            let decoder = JSONDecoder()
            do {
                let item = try decoder.decode(StockQuote.self, from: data)
                self.listStock = item.quoteResponse.result
            } catch {
                self.delegate?.viewModelUpdateFailed(error: SPServerResponseError.JsonParsing)
                print(error)
            }
        }, failure: { (error) in
            self.delegate?.viewModelUpdateFailed(error: error)
            print(error)
        })
    }
    // MARK: - Data formatting methods
    func postStockChange(at indexPath: IndexPath) -> NSAttributedString? {
        guard let stock = listStock?[indexPath.row] else {return nil}
        let results = postChangevalues(for: stock)
        let style = SPStyle(fontType: .regular, sizeType: .compact, colorType: results.color)
        return attributedString(for: results.formattedString, with: style)
    }

    func stockChange(at indexPath: IndexPath) -> (colorType: SPColorType, formattedValue: String?) {
        guard let stock = listStock?[indexPath.row] else {return (SPColorType.lightGreen, nil)}
        let results = changeValues(for: stock)
        return (results.color, results.formattedString)
    }

    // MARK: - Data formatting helper methods
    private func color(for value: Double) -> SPColorType {
        return value >= 0.0 ? SPColorType.lightGreen : SPColorType.lightRed
    }

    private func attributedString(for value: String, with style: SPStyle) -> NSAttributedString {
        let left = NSAttributedString.attributedString(text: "Post: ", style: SPStyle.elementDescription)
        let right = NSAttributedString.attributedString(text: value, style: style)
        let attributed = NSMutableAttributedString()
        attributed.append(left)
        attributed.append(right)
        return attributed
    }

    private func postChangevalues(for stock: Stock) -> (color: SPColorType, formattedString: String) {
        switch selectedChangeFormat {
            case .percent:
                let result = String(format: "%.2f%%", stock.preMarketChangePercent)
                return (color(for: stock.preMarketChangePercent), result)
            case .value:
                let result = String(format: "%.2f", stock.preMarketChange)
                return (color(for: stock.preMarketChange), result)
        }
    }

    private func changeValues(for stock: Stock) -> (color: SPColorType, formattedString: String) {
        switch selectedChangeFormat {
            case .percent:
                let result = String(format: "%.2f%%", stock.regularMarketChangePercent)
                return (color(for: stock.regularMarketChangePercent), result)
            case .value:
                let result = String(format: "%.2f", stock.regularMarketChange)
                return (color(for: stock.regularMarketChange), result)
        }
    }
}
