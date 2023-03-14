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
    
    var id: String = ""
    var familyID: String = ""
    var jwtToken: String = ""
    var fcmToken: String = ""
    
    public mutating func clearData() {
        id = ""
        familyID = ""
        jwtToken = ""
    }
}


