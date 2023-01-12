//
//  HomeArchiveResult.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import Foundation

struct HomeArchiveResult: Codable{
    let record: RecordResult
    let commentWriters: [CommentWriterResult]
}

struct CommentWriterResult: Codable{
    let writerId: Int
    let writerPhoto: String?
}
