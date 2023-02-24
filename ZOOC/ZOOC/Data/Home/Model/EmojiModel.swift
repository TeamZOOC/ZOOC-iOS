//
//  EmojiModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/25.
//

import UIKit

struct EmojiModel{
    var image: UIImage
    var tag: Int
}

extension EmojiModel{
    
    static let data: [EmojiModel] = [
        EmojiModel(image: Image.emojiDancing, tag: 1),
        EmojiModel(image: Image.emojiHeart, tag: 2),
        EmojiModel(image: Image.emojiSmile, tag: 3),
        EmojiModel(image: Image.emojiSad, tag: 4),
        EmojiModel(image: Image.emojiThumb, tag: 5),
        EmojiModel(image: Image.emojiSurprise, tag: 6),
        EmojiModel(image: Image.emojiHug, tag: 7),
        EmojiModel(image: Image.emojiDog, tag: 8)]
}
