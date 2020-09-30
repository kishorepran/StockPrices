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
    func postStockChange(at indexPath: IndexPath) -> NSAttributedString? {
        guard let stock = listStock?[indexPath.row] else {return nil}
        let finalValue = selectedChangeFormat == .percent ? stock.postPercentChange : stock.postValueChange
        return attributedString(for: finalValue)
    }
    func stockChange(at indexPath: IndexPath) -> String? {
        guard let stock = listStock?[indexPath.row] else {return nil}
        let shouldShowPercent = selectedChangeFormat == .percent
        return shouldShowPercent ? stock.percentChange : stock.valueChange
    }
    func attributedString(for value: String) -> NSAttributedString {
        let greenStyle = SPStyle(fontType: .regular, sizeType: .compact, colorType: .lightGreen)
        let left = NSAttributedString.attributedString(text: "Post: ", style: SPStyle.elementDescription)
        let right = NSAttributedString.attributedString(text: value, style: greenStyle)
        let attributed = NSMutableAttributedString()
        attributed.append(left)
        attributed.append(right)
        return attributed
    }
}
