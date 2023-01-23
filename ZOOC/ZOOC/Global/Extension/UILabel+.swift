//
//  UILabel+.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

extension UILabel {
        func asFontColor(targetString: String, font: UIFont? = nil, color: UIColor? = nil) {
            let fullText = text ?? ""
            let attributedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: targetString)
            attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
            attributedText = attributedString
        }
}
