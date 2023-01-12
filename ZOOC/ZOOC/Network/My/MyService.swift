//
//  MyService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum MyService {
    case getMyPageData
    //case patchUserProfile(nickName: String, photo: //file)
    case deleteAccount
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyPageData:
            return "/family/mypage"
//        case .patchUserProfile:
//            return "user/profile?photo={true/false}"
        case .deleteAccount:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageData:
            return .get
//        case .patchUserProfile:
//            return .patch
        case .deleteAccount:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageData:
            return .requestPlain
//        case .patchUserProfile:
//            return .requestJSONEncodable()
        case .deleteAccount:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        return APIConstants.hasTokenHeader
    }
}

