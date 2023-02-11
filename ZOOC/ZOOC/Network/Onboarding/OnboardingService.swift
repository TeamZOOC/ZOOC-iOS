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
    case postRegisterPet(petNames: [String],
                         files: [UIImage])
    case postKakaoSocialLogin(accessToken: String)
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .getInviteCode(let familyId):
            return URLs.getInviteCode.replacingOccurrences(of: "{familyId}", with: familyId)
        case .postRegisterUser:
            return URLs.registerUser
        case .postRegisterPet(petNames: _, files: _):
            return URLs.registerPet.replacingOccurrences(of: "{familyId}", with: "1")
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
        case .postRegisterPet(petNames: _, files: _):
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
        case .postRegisterPet(petNames: let names, files: let photos):
            var multipartFormDatas: [MultipartFormData] = []
//            multipartFormDatas.append(MultipartFormData(provider: .data("\(names)".data(using: .utf8)!), name: "petNames"))
//
//            multipartFormDatas.append(MultipartFormData(provider: .data("\(photos)".data(using: .utf8)!), name: "files"))
            for name in names {
                multipartFormDatas.append(MultipartFormData(
                    provider: .data("\(name)".data(using: .utf8)!),
                    name: "petNames"))
            }

            //photo! 나중에 바꿔주기
            for photo in photos {
                    let photo = photo.jpegData(compressionQuality: 1.0) ?? Data()

                    multipartFormDatas.append(MultipartFormData(
                        provider: .data("\(photo)".data(using: .utf8)!),
                        name: "files",
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
        case .postRegisterPet(petNames: _, files: _):
            return [APIConstants.contentType: APIConstants.multipartFormData,
                    APIConstants.auth : APIConstants.accessToken]
        case .postKakaoSocialLogin(accessToken: let accessToken):
            return [APIConstants.contentType: APIConstants.applicationJSON,
                    APIConstants.auth : accessToken]
        }
    }
    
}

