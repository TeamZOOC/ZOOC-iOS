//
//  HomeService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit
import Moya

enum RecordService{
    case getTotalPet(familyID: String)
    case postRecord(familyID: String, photo: UIImage, content: String, pets: [Int])
}

extension RecordService: BaseTargetType{
    var path: String {
        switch self{
        case .getTotalPet(let familyID):
            return URLs.totalPet.replacingOccurrences(of: "{familyId}", with: familyID)
        case .postRecord(familyID: let familyID, photo: let photo, content: let content, pets: let pets):
            return URLs.postRecord.replacingOccurrences(of: "{familyId}", with: familyID)
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getTotalPet:
            return .get
        case .postRecord:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getTotalPet:
            return .requestPlain
        case .postRecord(familyID: let familyID, photo: let photo, content: let content, pets: let pets):
            print("희재야 부탁해~~~~❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
            return .requestPlain
            //희재야 부탁해~~~~~~~!!!!
            
        }
    }
    
    
}
