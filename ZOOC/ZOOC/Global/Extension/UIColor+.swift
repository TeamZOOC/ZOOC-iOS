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
    
    //MARK: Brand Colors
    class var zoocMainGreen: UIColor {
        return UIColor(r: 94, g: 203, b: 144)
    }
    
    class var zoocSubGreen: UIColor {
        return UIColor(r: 104, g: 212, b: 154)
    }
    
    class var zoocGradientGreen: UIColor {
        return UIColor(r: 104, g: 212, b: 154)  //TODO: 그라데이션 기능 구현하기 
    }
    
    //MARK: Gray Scale Colors
    
    class var zoocWhite1: UIColor {
        return UIColor(r: 255, g: 255, b: 255)
    }
    
    class var zoocWhite2: UIColor {
        return UIColor(r: 248, g: 248, b: 248)
    }
    
    class var zoocWhite3: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    class var zoocLightGray: UIColor {
        return UIColor(r: 224, g: 224, b: 224)
    }
    
    class var zoocGray1: UIColor {
        return UIColor(r: 189, g: 189, b: 189)
    }
    
    class var zoocGray2: UIColor {
        return UIColor(r: 130, g: 130, b: 130)
    }
    
    class var zoocGray3: UIColor {
        return UIColor(r: 85, g: 85, b: 85)
    }
    
    class var zoocDarkGray1: UIColor {
        return UIColor(r: 79, g: 79, b: 79)
    }
    
    class var zoocDarkGray2: UIColor {
        return UIColor(r: 51, g: 51, b: 51)
    }
    
    //MARK: Green Scale Colors
    
    class var zoocBackgroundGreen: UIColor {
        return UIColor(r: 240, g: 242, b: 239)
    }
    
    class var zoocLightGreen: UIColor {
        return UIColor(r: 222, g: 227, b: 219)
    }
    
    class var zoocDarkGreen: UIColor {
        return UIColor(r: 136, g: 140, b: 134)
    }
    
    class var zoocShadowGreenColor: UIColor {
        return UIColor(r: 119, g: 184, b: 149)
    }
    
}
