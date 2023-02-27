//
//  EmojiModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/25.
//

import UIKit

struct EmojiModel{
    var image: UIImage
    var id: Int
}

extension EmojiModel{
    
    static let data: [EmojiModel] = [
        EmojiModel(image: Image.emojiDancing, id: 0),
        EmojiModel(image: Image.emojiHeart, id: 1),
        EmojiModel(image: Image.emojiSmile, id: 2),
        EmojiModel(image: Image.emojiSad, id: 3),
        EmojiModel(image: Image.emojiThumb, id: 4),
        EmojiModel(image: Image.emojiSurprise, id: 5),
        EmojiModel(image: Image.emojiHug, id: 6),
        EmojiModel(image: Image.emojiDog, id: 7)]
}
