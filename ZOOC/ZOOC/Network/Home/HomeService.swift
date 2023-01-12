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
    case getNotice
}

extension HomeService: BaseTargetType {
     
    var path: String {
        switch self {
        case .getMission(let familyID):
            return URLs.getMission.replacingOccurrences(of: "{familyId}", with: "\(familyID)")
        case .getTotalPet(let familyID):
            return URLs.totalPet.replacingOccurrences(of: "{familyId}", with: "\(familyID)")
        case .getTotalArchive(let familyID):
            return URLs.totalRecord.replacingOccurrences(of: "{familyId}", with: "\(familyID)")
        case .getNotice:
            return URLs.getNotice
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
        case .getNotice:
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
        case .getNotice:
            return .requestPlain
        }
    }
}

