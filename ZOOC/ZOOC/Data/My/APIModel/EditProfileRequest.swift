//
//  MyEditProfileModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/28.
//

import UIKit

struct EditProfileRequest {
    var hasPhoto: Bool
    var nickName: String
    var profileImage: UIImage?
    
    init(hasPhoto: Bool = true,
         nickName: String = "",
         profileImage: UIImage? = nil) {
        self.hasPhoto = hasPhoto
        self.nickName = nickName
        self.profileImage = profileImage
    }
}
