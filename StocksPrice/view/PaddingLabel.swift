//
//  PaddingLabel.swift
//  PaddingLabel
//
//  Created by levantAJ on 11/11/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//  Courtesy: https://github.com/levantAJ/PaddingLabel/blob/master/PaddingLabel/PaddingLabel.swift

import UIKit

@IBDesignable open class PaddingLabel: UILabel {
    
    @IBInspectable open var topInset: CGFloat = 2.0
    @IBInspectable open var bottomInset: CGFloat = 2.0
    @IBInspectable open var leftInset: CGFloat = 5.0
    @IBInspectable open var rightInset: CGFloat = 5.0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
