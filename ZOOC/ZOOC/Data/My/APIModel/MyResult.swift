//
//  MyResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/12.
//

import Foundation

// MARK: - MyResult
struct MyResult: Codable {
    let user: MyUser
    let familyMember: [MyUser]
    let pet: [MyPet]
}

// MARK: - User
struct MyUser: Codable {
    let id: Int
    var nickName: String
    var photo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nickName = "nick_name"
        case photo
    }
}

// MARK: - Pet
struct MyPet: Codable {
    let id: Int
    let name: String
    let photo: String?
}

