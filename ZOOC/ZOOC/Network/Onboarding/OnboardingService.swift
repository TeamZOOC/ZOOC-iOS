//
//  OnboardingService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum OnboardingService {
    case registerUser(param: OnboardingRegisterUserRequestDto)

}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .registerUser:
            return URLs.registerUser
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .registerUser(param: _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .registerUser(param: let param):
            return .requestJSONEncodable(param)
        }
    }
}



