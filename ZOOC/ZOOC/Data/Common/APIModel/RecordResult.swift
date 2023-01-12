//
//  RecordResult.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import Foundation

struct RecordResult: Codable{
    let id: Int
    let photo: String
    let content: String
    let date: String
    let writerPhoto: String?
    let writerName: String
}
