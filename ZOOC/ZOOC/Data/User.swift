//
//  User.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import Foundation

struct User {
    static var shared = User()
    private init() {}
    
    var id: String = "1"
    var familyID: String = "1"
    var jwtToken: String = ""
    var fcmToken: String = ""
}

