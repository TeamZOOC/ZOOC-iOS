//
//  UIButton+.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit
import Kingfisher

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
    
    func kfSetButtonImage(url : String) {
        if let url = URL(string: url) {
            kf.setImage(with: url,
                        for: .normal, placeholder: nil,
                        options: [.transition(.fade(1.0))], progressBlock: nil)
        }
    }
    
    func makeButtonCornerRadius(ratio: CGFloat) {
        layer.cornerRadius = ratio
        clipsToBounds = true
    }
    
    func makeButtonBorder(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}





