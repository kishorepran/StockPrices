//
//  SPViewModel.swift
//  StocksPrice
//
//  Created by Pran Kishore on 29.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import Foundation

class SPViewModel: SPBaseViewModel {
    
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
