//
//  UIImageView+.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import UIKit
import Kingfisher

extension UIImageView{
    func kfSetImage(url : String){
        let url = URL(string: url)
        kf.indicatorType = .activity
        kf.setImage(with: url,
                    placeholder: nil,
                    options: [.transition(.fade(1.0))], progressBlock: nil)
    }
}
