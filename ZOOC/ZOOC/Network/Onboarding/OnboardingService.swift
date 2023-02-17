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
    case postRegisterPet(param: OnboardingRegisterPetRequestDto)
    case postKakaoSocialLogin(accessToken: String)
    case postAppleSocialLogin(identityToken: String)
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .getInviteCode(let familyId):
            return URLs.getInviteCode.replacingOccurrences(of: "{familyId}", with: familyId)
        case .postRegisterUser:
            return URLs.registerUser
        case .postRegisterPet(param: _):
            return URLs.registerPet.replacingOccurrences(of: "{familyId}", with: "1")
        case .postKakaoSocialLogin:
            return URLs.kakaoLogin
        case .postAppleSocialLogin:
            return URLs.appleLogin
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
        case .postAppleSocialLogin:
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
        case .postAppleSocialLogin:
            return .requestPlain
        case .postRegisterPet(param: let param):
            var multipartFormDatas: [MultipartFormData] = []
            
            for name in param.petNames {
                multipartFormDatas.append(MultipartFormData(
                    provider: .data("\(name)".data(using: .utf8)!),
                    name: "petNames"))
            }

            //photo! 나중에 바꿔주기
            for photo in param.files {
                    multipartFormDatas.append(MultipartFormData(
                        provider: .data("\(photo!)".data(using: .utf8)!),
                        name: "files",
                        fileName: "image.jpeg",
                        mimeType: "image/jpeg"))
            }
            
            for isPhoto in param.isPetPhotos {
                multipartFormDatas.append(MultipartFormData(
                    provider: .data("\(isPhoto)".data(using: .utf8)!),
                    name: "isPetPhotos"))
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
            return [APIConstants.contentType: APIConstants.multipartFormData,
                    APIConstants.auth : APIConstants.accessToken]
        case .postKakaoSocialLogin(accessToken: let accessToken):
            return [APIConstants.contentType: APIConstants.applicationJSON,
                    APIConstants.auth : accessToken]
        case .postAppleSocialLogin(identityToken: let identityToken):
            return [APIConstants.contentType: APIConstants.applicationJSON,
                    APIConstants.auth : identityToken]
        }
    }
}


