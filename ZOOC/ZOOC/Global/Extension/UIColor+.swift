//
//  UIColor+.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/21.
//

import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255,green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}

//MARK: - Custom Color
extension UIColor{
    
    class var zoocWhite: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    class var zoocGreen: UIColor {
        return UIColor(r: 108, g: 186, b: 133)
    }
    
    
    
}
