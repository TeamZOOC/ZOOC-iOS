//
//  MyService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum MyService {
    case getMyPageData
    //case patchUserProfile(nickName: String, photo: Data?)
    case deleteAccount
}

extension MyService: BaseTargetType {
    var path: String {
        switch self {
        case .getMyPageData:
            return "/family/mypage"
//        case .patchUserProfile(photo: Bool):
//            return "user/profile?photo=\(photo)"
        case .deleteAccount:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPageData:
            return .get
//        case .patchUserProfile(nickName: _, photo: _):
//            return .patch
        case .deleteAccount:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMyPageData:
            return .requestPlain
            
//        case .patchUserProfile(nickName: String, photo: Data):
//            var multipartFormData: [MultipartFormData] = []
//
//            let imageData = MultipartFormData(provider: .data(photo.image),
//                                              name: "profileImage",
//                                              fileName: "profileImage.jpeg",
//                                              mimeType: "image/jpeg")
//            multipartFormData.append(imageData)
//
//            let jsonParam = ["nickName": nickName]
//
//            let data = try! JSONSerialization.data(withJSONObject: jsonParam.asParameter(),
//                                                   options: .prettyPrinted)
//
//            let jsonString = String(data: data, encoding: .utf8)!
//
//            let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!),
//                                               name: "profileNickName",
//                                               mimeType: "application/json"
//            )
//            multipartFormData.append(stringData)
//            return .uploadMultipart(multipartFormData)
//
        case .deleteAccount:
            return .requestPlain
        }
    }
    
    var headers: [String : String]?{
        return APIConstants.hasTokenHeader
    }
}

