//
//  OnboardingService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation
import Moya

enum OnboardingService {
    case getInviteCode(familyId: String)
}

extension OnboardingService: BaseTargetType {
    
    var path: String {
        switch self {
        case .getInviteCode(let familyId):
            return URLs.getInviteCode.replacingOccurrences(of: "{familyId}", with: familyId)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getInviteCode:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getInviteCode:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        return APIConstants.hasTokenHeader
    }
}
