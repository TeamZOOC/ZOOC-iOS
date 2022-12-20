//
//  Adjusted+.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/21.
//

import UIKit

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 390
        let ratioH: CGFloat = UIScreen.main.bounds.height / 844
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
}

extension Double {
     var adjusted: Double {
         let ratio: Double = Double(UIScreen.main.bounds.width) / 390
         let ratioH: Double = Double(UIScreen.main.bounds.height) / 844
         return ratio <= ratioH ? self * ratio : self * ratioH
     }
 }

extension Int {
     var adjusted: Int {
         let ratio: Int = Int(UIScreen.main.bounds.width) / 390
         let ratioH: Int = Int(UIScreen.main.bounds.height) / 844
         return ratio <= ratioH ? self * ratio : self * ratioH
     }
 }

