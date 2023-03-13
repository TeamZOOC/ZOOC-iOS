//
//  UILabel+.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

extension UILabel {
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        attributedText = attributedString
    }
    
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
    
    func setAttributeLabel(targetString: [String], color: UIColor?, spacing: CGFloat) {
        let fullText = text ?? ""
        let style = NSMutableParagraphStyle()
        let attributedString = NSMutableAttributedString(string: fullText)
        
        for target in targetString {
            let range = (fullText as NSString).range(of: target)
            attributedString.addAttributes([.font: font as Any, .foregroundColor: color as Any], range: range)
        }
        
        style.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
        
    }

}
