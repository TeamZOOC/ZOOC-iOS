//
//  HomeMissionModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import Foundation
struct HomeMissionResult: Codable{
    let id: Int
    let missionContent: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case missionContent = "mission_content"
    }
}
