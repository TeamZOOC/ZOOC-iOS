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
    static let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTY3MzQ2MzMxMiwiZXhwIjoxNjc0MDY4MTEyfQ.AKlzlfMwUIBtiVORDzX7NpPcgCKwjtji9VJOuoqq7lc"
    
}

extension APIConstants{
    
    static let noTokenHeader = [contentType: applicationJSON]
    static let hasTokenHeader = [contentType: applicationJSON,
                                 auth: accessToken]
    
}
