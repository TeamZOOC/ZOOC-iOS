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
    static let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE3LCJpYXQiOjE2NzM0NjMzMTIsImV4cCI6MTgwMDAwMDAwMH0.mg8gzpzGvaAcJqCgi1QgaYGDZmsRpA184KNtPmYUch4"
    
    
}

extension APIConstants{
    static let noTokenHeader = [contentType: applicationJSON]
    static let hasTokenHeader = [contentType: applicationJSON,
                                       auth : accessToken]
    static let multipartHeader = [contentType: multipartFormData,
                                        auth : accessToken]
    
}
