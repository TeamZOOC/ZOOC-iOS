//
//  UIStackView+.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/21.
//

import UIKit

extension UIStackView{
    
    func addArrangedSubViews(_ views: UIView...){
        views.forEach {  self.addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

