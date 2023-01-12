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
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyPageData:
            return "/family/mypagep"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        return APIConstants.hasTokenHeader
    }
}

