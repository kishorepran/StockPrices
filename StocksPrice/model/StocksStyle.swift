//
//  StocksStyle.swift
//  StocksPrice
//
//  Created by Pran Kishore on 27.09.20.
//  Copyright © 2020 Sample Solutions. All rights reserved.
//

import UIKit

//MARK:- Color types
public enum SPColorType: String {

    case lightGreen // 68 157 92
    case darkGreen //103 172 135
    case blackText//18 18 18
    case lightBlackText//106 106 106
    case lightRed //214 44 50
    case darkRed //171 83 96
    case white //171 83 96

    public var color: UIColor {
        return color(for: self)
    }

    private func color(for description: SPColorType) -> UIColor {
        switch description {
        case .lightGreen: return UIColor.systemGreen.withAlphaComponent(0.8)
        case .darkGreen: return UIColor.systemGreen
        case .blackText: return UIColor(red: 18.0/255.0, green: 18.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        case .lightBlackText: return UIColor(red: 106.0/255.0, green: 106.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        case .lightRed: return UIColor.systemRed.withAlphaComponent(0.8)
        case .darkRed: return UIColor.systemRed
        case .white: return UIColor.white
        }
    }
}

//MARK:- Font Size
public enum SPSizeType: CGFloat, RawRepresentable, CustomStringConvertible {

    public typealias RawValue = CGFloat

    case tiny
    case small
    case compact
    case medium
    case big

    public var rawValue: RawValue {
        switch self {
        case .tiny: return 10.0
        case .small: return 12.0
        case .compact: return 14.0
        case .medium: return 16.0
        case .big: return 20.0
        }
    }

    public init?(rawValue: RawValue) {

        switch rawValue {
        case 10.0: self = .tiny
        case 12.0: self = .small
        case 14.0: self = .compact
        case 16.0: self = .medium
        case 20.0: self = .big
        default:
            self = .tiny
        }
    }

    public var description: String {
        return "SPSizeType Size :\(fontSize)"
    }

    public var fontSize: CGFloat {
        return rawValue
    }
}

//MARK:- Font Type
public enum SPFontType: String, CustomStringConvertible {

    case light
    case bold
    case regular

    public var description: String {
        return "StyleDescription : Font name : \(fontName)"
    }

    public var fontName: String {
        return rawValue
    }

    public var fontWeight: UIFont.Weight {
        switch self {
        case .light: return UIFont.Weight.light
        case .regular: return UIFont.Weight.regular
        case .bold: return UIFont.Weight.bold
        }
    }

    public func font(with pointSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: pointSize)
    }

    public func font(with pointSize: SPSizeType) -> UIFont {
        return font(with: pointSize.fontSize)
    }
}

//MARK:- Style

open class SPStyle: CustomStringConvertible {

    fileprivate let fontType: SPFontType
    fileprivate let sizeType: SPSizeType
    fileprivate let colorType: SPColorType

    public init (fontType: SPFontType, sizeType: SPSizeType, colorType: SPColorType) {
        self.fontType = fontType
        self.sizeType = sizeType
        self.colorType = colorType
    }

    var font: UIFont {
        return UIFont.systemFont(ofSize: sizeType.fontSize, weight: fontType.fontWeight)
    }

    open var description: String {
        return "SPStyle: \(fontType) : \(sizeType) : \(colorType)"
    }

    public static var elementName: SPStyle {
        return SPStyle(fontType: .bold, sizeType: .medium, colorType: .blackText)
    }
    public static var elementDescription: SPStyle {
        return SPStyle(fontType: .regular, sizeType: .compact, colorType: .lightBlackText)
    }

    public static var elementMetaData: SPStyle {
        return SPStyle(fontType: .regular, sizeType: .compact, colorType: .white)
    }
}

//MARK:- Extentions

public extension NSAttributedString {

    static func attributedString(text: String, style: SPStyle) -> NSAttributedString {
        let font = style.font
        let textColor = style.colorType.color

        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: font ,
            .foregroundColor: textColor] )
        return attributedString
    }

}

public extension UILabel {
    func apply(style: SPStyle) {
        font = style.font
        textColor = style.colorType.color
    }

}
