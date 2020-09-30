//
//  StocksPriceTableViewCell.swift
//  StocksPrice
//
//  Created by Pran Kishore on 27.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Reusable

class StocksPriceTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lblStockCode: UILabel!
    @IBOutlet weak var lblStockName: UILabel!
    @IBOutlet weak var lblStockPrice: UILabel!
    @IBOutlet weak var lblStockChange: PaddingLabel!
    @IBOutlet weak var lblStockPostChange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupStyle()
    }
    private func setupStyle() {
        // Set up colors and font size
        lblStockCode.apply(style: SPStyle.elementName)
        lblStockName.apply(style: SPStyle.elementDescription)
        lblStockPrice.apply(style: SPStyle.elementName)
        lblStockChange.apply(style: SPStyle.elementMetaData)
        lblStockChange.layer.cornerRadius = 2.0
        lblStockChange.clipsToBounds = true
    }
}
