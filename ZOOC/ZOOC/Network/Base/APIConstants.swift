//
//  APIConstants.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation
import Moya

struct APIConstants{
    
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
    static let auth = "Authorization"
}

extension APIConstants{
    static let noTokenHeader = [contentType: applicationJSON]
    static let hasTokenHeader = [contentType: applicationJSON,
                                       auth : User.shared.jwtToken]
    static let multipartHeader = [contentType: multipartFormData,
                                        auth : User.shared.jwtToken]
}
