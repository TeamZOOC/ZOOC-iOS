//
//  HomeDetailArchiveResult.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import Foundation

struct HomeDetailArchiveResult: Codable {
    let leftID, rightID: Int?
    let record: RecordResult
    let comments: [CommentResult]

    enum CodingKeys: String, CodingKey {
        case leftID = "leftId"
        case rightID = "rightId"
        case record, comments
    }
}

// MARK: - Comment
struct CommentResult: Codable {
    let isEmoji: Bool
    let nickName: String
    let photo: String?
    let content: String?
    let emoji: Int?
    let date: String
}

