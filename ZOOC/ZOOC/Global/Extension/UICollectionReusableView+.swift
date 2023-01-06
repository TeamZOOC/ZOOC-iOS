//
//  UICollectionReusableView+.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/06.
//

import UIKit

extension UICollectionReusableView{
    static var reuseCellIdentifier  : String {
        return String(describing: self)
    }
}


