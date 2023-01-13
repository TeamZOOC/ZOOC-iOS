//
//  OnboardingService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum OnboardingService {
    case postRegisterUser(param: OnboardingRegisterUserRequestDto)
    case postKakaoSocialLogin
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .postRegisterUser:
            return URLs.registerUser
        case .postKakaoSocialLogin:
            return URLs.socialLogin
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postRegisterUser(param: _):
            return .post
        case .postKakaoSocialLogin:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .postRegisterUser(param: let param):
            return .requestJSONEncodable(param)
        case .postKakaoSocialLogin:
            return .requestPlain
        }
    }
}



