//
//  HomeService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit
import Moya

enum RecordService{
    case getTotalPet(familyID: String)
    case postRecord(familyID: String, photo: UIImage, content: String, pets: [Int])
}

extension RecordService: BaseTargetType{
    var path: String {
        switch self{
        case .getTotalPet(let familyID):
            return URLs.totalPet.replacingOccurrences(of: "{familyId}", with: familyID)
        case .postRecord(familyID: let familyID, photo: _, content: _, pets: _):
            return URLs.postRecord.replacingOccurrences(of: "{familyId}", with: familyID)
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getTotalPet:
            return .get
        case .postRecord:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getTotalPet:
            return .requestPlain
        case .postRecord(familyID: _, photo: let photo, content: let content, pets: let pets):
            
            var multipartFormData: [MultipartFormData] = []
            
            let photo = photo.jpegData(compressionQuality: 1.0) ?? Data()
            
            for i in 0...pets.count - 1{
                let pet = pets[i].description.data(using: .utf8) ?? Data()
                let petData = MultipartFormData(provider: .data(pet),
                                                name: "pet[\(i)]",
                                                mimeType: "application/json")
                
                multipartFormData.append(petData)
            }


            let contentData = MultipartFormData(provider: .data(content.data(using: String.Encoding.utf8)!),
                                                           name: "content",
                                                           mimeType: "application/json")
            let imageData = MultipartFormData(provider: .data(photo),
                                                          name: "file",
                                                          fileName: "image.jpeg",
                                                          mimeType: "image/jpeg")
        
            
            multipartFormData.append(contentData)
            multipartFormData.append(imageData)
            
            return .uploadMultipart(multipartFormData)
            
        }
    }
    
    
}
