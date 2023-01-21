//
//  HomeService.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

enum HomeService {
    case getMission(familyID: String)
    case getTotalPet(familyID: String)
    case getTotalArchive(familyID: String,petID: String)
    case getDetailArchive(familyID: String, recordID: String)
    case getNewDetailArchive(familyID: String, recordID: String, petID: String)
    case getNotice
    case postComment(recordID: String, comment: String)
}

extension HomeService: BaseTargetType {
     
    var path: String {
        switch self {
        case .getMission(let familyID):
            return URLs.getMission.replacingOccurrences(of: "{familyId}", with: familyID)
        case .getTotalPet(let familyID):
            return URLs.totalPet.replacingOccurrences(of: "{familyId}", with: familyID)
        case .getTotalArchive(familyID: let familyID, petID: let petID):
            return URLs.totalRecord.replacingOccurrences(of: "{familyId}", with: familyID).replacingOccurrences(of: "{petId}", with: petID)
        case .getDetailArchive(familyID: let familyID, recordID: let recordID):
            return URLs.detailRecord.replacingOccurrences(of: "{familyId}", with: familyID).replacingOccurrences(of: "{recordId}", with: recordID)
        case .getNotice:
            return URLs.getNotice
        case .postComment(recordID: let recordID, comment: let comment):
            return URLs.postComment.replacingOccurrences(of: "{recordId}", with: recordID)
        case .getNewDetailArchive(familyID: let familyID, recordID: let recordID, petID: let petID):
            return "/record/detail/{familyId}/{petId}/{recordId}".replacingOccurrences(of: "{familyId}", with: familyID).replacingOccurrences(of: "{petId}", with: petID).replacingOccurrences(of: "{recordId}", with: recordID)
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .getMission:
            return .get
        case .getTotalPet:
            return .get
        case .getTotalArchive:
            return .get
        case .getDetailArchive:
            return .get
        case .getNotice:
            return .get
        case .postComment:
            return .post
        case .getNewDetailArchive:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMission:
            return .requestPlain
        case .getTotalPet:
            return .requestPlain
        case .getTotalArchive:
            return .requestPlain
        case .getDetailArchive:
            return .requestPlain
        case .getNotice:
            return .requestPlain
        case .postComment(recordID: let recordID, comment: let comment):
            let body = HomeCommentReqeust(content: comment)
            return .requestJSONEncodable(body)
        case .getNewDetailArchive(familyID: let familyID, recordID: let recordID, petID: let petID):
            return .requestPlain
        }
    }
}

