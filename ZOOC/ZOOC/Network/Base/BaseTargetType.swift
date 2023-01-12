//
//  BaseTargetType.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType{ }

extension BaseTargetType{
    
    var baseURL: URL{
        return URL(string: (Bundle.main.infoDictionary?["BASE_URL"] as! String))!
    }
    
    var headers: [String : String]?{
        return APIConstants.hasTokenHeader
    }
    
}
