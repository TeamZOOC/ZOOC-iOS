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
    static let auth = "Authorization"
    static let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE3LCJpYXQiOjE2NzM0NjMzMTIsImV4cCI6MTY3NDA2ODExMn0.9ZTqlzqI4jDsSnO9yHPP2pzOjmDRqs17KaQkm3yHr1c"
    
}

extension APIConstants{
    
    static let noTokenHeader = [contentType: applicationJSON]
    static let hasTokenHeader = [contentType: applicationJSON,
                                       auth : accessToken]
    
}
