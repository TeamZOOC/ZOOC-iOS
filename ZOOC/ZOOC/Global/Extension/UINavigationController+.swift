//
//  UINavigationController+.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/06.
//

import UIKit
extension UINavigationController{
    var previousViewController: UIViewController? {
        let count = self.viewControllers.count
        return count < 2 ? self : self.viewControllers[count - 2]
    }
}
