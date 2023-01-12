//
//  MyResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/12.
//

import Foundation

// MARK: - MyResult
struct MyResult: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User
    let familyMember: [User]
    let pet: [Pet]
}

// MARK: - User
struct User: Codable {
    let id: Int
    let nickName, photo: String

    enum CodingKeys: String, CodingKey {
        case id
        case nickName = "nick_name"
        case photo
    }
}

// MARK: - Pet
struct Pet: Codable {
    let id: Int
    let name, photo: String
}

