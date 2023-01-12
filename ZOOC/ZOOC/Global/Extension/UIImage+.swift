//
//  UIImage.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import UIKit

extension UIImage{
    class func zoocEmoji(_ id: Int) -> UIImage{
        switch id{
        case 0: return Image.emojiDancing
        case 1: return Image.emojiHeart
        case 2: return Image.emojiSmile
        case 3: return Image.emojiSad
        case 4: return Image.emojiThumb
        case 5: return Image.emojiSurprise
        case 6: return Image.emojiHug
        case 7: return Image.emojiDog
        default: return UIImage()
        }
    }
}
