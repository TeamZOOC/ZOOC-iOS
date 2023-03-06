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
    case getFamily
    case getInviteCode(familyId: String)
    case postJoinFamily(_ request: OnboardingJoinFamilyRequest)
    case postRegisterPet(_ request: OnboardingRegisterPetRequest)
    case postKakaoSocialLogin(accessToken: String)
    case postAppleSocialLogin(_ request: OnboardingAppleSocialLoginRequest)
    case patchFCMToken(fcmToken: String)
}

extension OnboardingService: BaseTargetType {
    var path: String {
        switch self {
        case .getInviteCode(let familyId):
            return URLs.getInviteCode.replacingOccurrences(of: "{familyId}", with: familyId)
        case .postJoinFamily:
            return URLs.joinFamily
        case .postRegisterPet(let request):
            return URLs.registerPet.replacingOccurrences(of: "{familyId}", with: User.shared.familyID) //TODO: 1로 고정되어있음 꽤 큰 작업이 될지도
        case .postKakaoSocialLogin:
            return URLs.kakaoLogin
        case .postAppleSocialLogin:
            return URLs.appleLogin
        case .getFamily:
            return URLs.getFamily
        case .patchFCMToken:
            return URLs.fcmToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getInviteCode:
            return .get
        case .postJoinFamily:
            return .post
        case .postRegisterPet:
            return .post
        case .postKakaoSocialLogin:
            return .post
        case .postAppleSocialLogin:
            return .post
        case .getFamily:
            return .get
        case .patchFCMToken:
            return .patch
        }
    }
    
    
    var task: Task {
        switch self {
        case .getInviteCode:
            return .requestPlain
            
        case .postJoinFamily(let param):
            return .requestJSONEncodable(param)
            
        case .postKakaoSocialLogin:
            return .requestPlain
            
        case .postAppleSocialLogin(let param):
            return .requestJSONEncodable(param)
            
        case .postRegisterPet(let param):
            var multipartFormDatas: [MultipartFormData] = []
            
            for name in param.petNames {
                multipartFormDatas.append(MultipartFormData(
                    provider: .data("\(name)".data(using: .utf8)!),
                    name: "petNames[]"))
            }

            //TODO: photo! 나중에 바꿔주기
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
                    name: "isPetPhotos[]"))
            }
            return .uploadMultipart(multipartFormDatas)
            
        case .getFamily:
            return .requestPlain
            
        case .patchFCMToken(fcmToken: let fcmToken):
            return .requestParameters(parameters: ["fcmToken": fcmToken],
                                      encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]?{
        switch self {
        case .getInviteCode(familyId: _):
            return APIConstants.hasTokenHeader
            
        case .postJoinFamily(param: _):
            return APIConstants.hasTokenHeader
            
        case .postRegisterPet(param: _):
            return APIConstants.multipartHeader
            
        case .postKakaoSocialLogin(accessToken: let accessToken):
            return [APIConstants.contentType: APIConstants.applicationJSON,
                    APIConstants.auth : accessToken]
            
        case .postAppleSocialLogin(param: _):
            return APIConstants.noTokenHeader
            
        case .getFamily:
            return APIConstants.hasTokenHeader
            
        case .patchFCMToken:
            return APIConstants.hasTokenHeader
        }
    }
}


