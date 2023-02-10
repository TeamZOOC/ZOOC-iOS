//
//  OnboardingService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya
import UIKit

enum OnboardingService {
    case getInviteCode(familyId: String)
    case postRegisterUser(param: OnboardingRegisterUserRequestDto)
    case postRegisterPet(familyId: String, param: OnboardingRegisterPetRequestDto)
    case postKakaoSocialLogin(accessToken: String)
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .getInviteCode(let familyId):
            return URLs.getInviteCode.replacingOccurrences(of: "{familyId}", with: familyId)
        case .postRegisterUser:
            return URLs.registerUser
        case .postRegisterPet(let familyId, param: _):
            return URLs.registerPet.replacingOccurrences(of: "{familyId}", with: familyId)
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
        case .postRegisterPet(param: _):
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
        case .postRegisterPet(familyId: _, param: let param):
            var multipartFormDatas: [MultipartFormData] = []
            
            for i in 0..<param.names.count {
                multipartFormDatas.append(MultipartFormData(
                    provider: .data("\(param.names[i])".data(using: .utf8)!),
                    name: "names[\(i)]"))
            }
            
            for j in 0..<param.photos.count {
                multipartFormDatas.append(MultipartFormData(
                    provider: .data("\(param.photos[j])".data(using: .utf8)!),
                    name: "photos[\(j)]",
                    fileName: "image.jpeg",
                    mimeType: "image/jpeg"))
            }
            return .uploadMultipart(multipartFormDatas)
        }
    }
    
    var headers: [String : String]?{
        switch self {
        case .getInviteCode(familyId: _):
            return APIConstants.hasTokenHeader
        case .postRegisterUser(param: _):
            return APIConstants.hasTokenHeader
        case .postRegisterPet(param: _):
            return APIConstants.multipart
        case .postKakaoSocialLogin(accessToken: let accessToken):
            return [APIConstants.contentType: APIConstants.applicationJSON,
                    APIConstants.auth : accessToken]
        }
    }
    
}

