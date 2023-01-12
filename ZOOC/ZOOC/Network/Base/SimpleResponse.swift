//
//  JustResponse.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/13.
//

import Foundation
struct SimpleResponse: Codable {
    var status: Int
    var success: Bool
    var message: String?
}
