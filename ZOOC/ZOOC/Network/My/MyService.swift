//
//  MyService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit

import Moya

enum MyService {
    case getMyPageData
    case patchUserProfile(isPhoto: Bool, nickName: String, photo: UIImage?)
    case deleteAccount
    case postRegisterPet(param: MyRegisterPetRequestDto)
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyPageData:
            return "/family/mypage"
        case .patchUserProfile:
            return "/user/profile"
        case .deleteAccount:
            return "/user"
        case .postRegisterPet:
            return URLs.registerPet.replacingOccurrences(of: "{familyId}", with: "2")
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageData:
            return .get
        case .patchUserProfile:
            return .patch
        case .deleteAccount:
            return .delete
        case .postRegisterPet:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageData:
            return .requestPlain
        case .patchUserProfile(isPhoto: let isPhoto, nickName: let nickName, photo: let photo):
            
            var multipartFormData: [MultipartFormData] = []
            
            let nickNameData = MultipartFormData(provider: .data(nickName.data(using: String.Encoding.utf8)!),
                                                 name: "nickName",
                                                 mimeType: "application/json")
            if let photo = photo{
                print("포토있음")
                let photo = photo.jpegData(compressionQuality: 1.0) ?? Data()
                let imageData = MultipartFormData(provider: .data(photo),
                                                  name: "file",
                                                  fileName: "image.jpeg",
                                                  mimeType: "image/jpeg")
                multipartFormData.append(imageData)
            }
            
            
            multipartFormData.append(nickNameData)
            return .uploadCompositeMultipart(multipartFormData, urlParameters: ["photo": isPhoto ? "true" : "false"])
            
            
        case .deleteAccount:
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
        case .postRegisterPet:
            return [APIConstants.contentType: APIConstants.multipartFormData,
                    APIConstants.auth : APIConstants.accessToken]
        default:
            return APIConstants.hasTokenHeader
        }
        
        
    }
}



