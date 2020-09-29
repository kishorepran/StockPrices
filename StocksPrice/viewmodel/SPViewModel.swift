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
    
    public var listStock: [Stock]? {
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
