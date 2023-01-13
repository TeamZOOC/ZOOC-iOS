//
//  HomeAlarmResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import Foundation

// MARK: - HomeAlarmResult

struct HomeNoticeResult: Codable {
    let writer: HomeNoticeWriter
    let created_time: String
}

// MARK: - HomeAlarmWriter

struct HomeNoticeWriter: Codable {
    let id: Int
    var nickName: String
    var photo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case nickName = "nick_name"
        case photo
    }
}



