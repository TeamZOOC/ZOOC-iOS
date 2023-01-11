//
//  HomeService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum HomeService {
    case getTotalPet(familyID: String)
}

extension HomeService: BaseTargetType {
     
    var path: String {
        switch self {
        case .getTotalPet(let familyID):
            return URLs.totalPet.replacingOccurrences(of: "{familyId}", with: "\(familyID)")
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .getTotalPet:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getTotalPet:
            return .requestPlain
        }
    }
    
}

