//
//  HomeService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum HomeService {
    case getMission(familyID: String)
    case getTotalPet(familyID: String)
    case getTotalArchive(familyID: String)
    case getDetailArchive(familyID: String, recordID: String)
}

extension HomeService: BaseTargetType {
     
    var path: String {
        switch self {
        case .getMission(let familyID):
            return URLs.getMission.replacingOccurrences(of: "{familyId}", with: familyID)
        case .getTotalPet(let familyID):
            return URLs.totalPet.replacingOccurrences(of: "{familyId}", with: familyID)
        case .getTotalArchive(let familyID):
            return URLs.totalRecord.replacingOccurrences(of: "{familyId}", with: familyID)
        case .getDetailArchive(familyID: let familyID, recordID: let recordID):
            return URLs.detailRecord.replacingOccurrences(of: "{familyId}", with: familyID).replacingOccurrences(of: "{recordId}", with: recordID)
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .getMission:
            return .get
        case .getTotalPet:
            return .get
        case .getTotalArchive:
            return .get
        case .getDetailArchive:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMission:
            return .requestPlain
        case .getTotalPet:
            return .requestPlain
        case .getTotalArchive:
            return .requestPlain
        case .getDetailArchive:
            return .requestPlain
        }
    }
    
}

