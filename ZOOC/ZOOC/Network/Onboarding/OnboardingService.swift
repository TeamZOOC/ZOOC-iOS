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
    case postRegisterUser(param: OnboardingRegisterUserRequestDto)
    case postKakaoSocialLogin
}

extension OnboardingService: BaseTargetType {
    
    var path: String {
        switch self {
        case .getInviteCode(let familyId):
            return URLs.getInviteCode.replacingOccurrences(of: "{familyId}", with: familyId)
        case .postRegisterUser:
            return URLs.registerUser
        case .postKakaoSocialLogin:
            return URLs.socialLogin
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getInviteCode:
            return .get
        case .postRegisterUser(param: _):
            return .post
        case .postKakaoSocialLogin:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getInviteCode:
            return .requestPlain
        case .postRegisterUser(param: let param):
            return .requestJSONEncodable(param)
        case .postKakaoSocialLogin:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        return APIConstants.hasTokenHeader
    }
}



