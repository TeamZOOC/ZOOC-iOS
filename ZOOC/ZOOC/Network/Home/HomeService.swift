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
    case getDetailPetArchive(familyID: String, recordID: String, petID: String)
    case getNotice
    case postComment(recordID: String, comment: String)
    case postEmojiComment(recordID: String, emojiID: Int)
}

extension HomeService: BaseTargetType {
     
    var path: String {
        switch self {
            
        case .getMission(let familyID):
            return URLs.getMission
                .replacingOccurrences(of: "{familyId}", with: familyID)
            
        case .getTotalPet(let familyID):
            return URLs.totalPet
                .replacingOccurrences(of: "{familyId}", with: familyID)
            
        case .getTotalArchive(familyID: let familyID, petID: let petID):
            return URLs.totalRecord
                .replacingOccurrences(of: "{familyId}", with: familyID)
                .replacingOccurrences(of: "{petId}", with: petID)
            
        case .getDetailArchive(familyID: let familyID, recordID: let recordID):  //아마 사용안함
            return URLs.detailRecord
                .replacingOccurrences(of: "{familyId}", with: familyID)
                .replacingOccurrences(of: "{recordId}", with: recordID)
            
        case .getDetailPetArchive(familyID: let familyID,
                                  recordID: let recordID,
                                  petID: let petID):
            return URLs.detailPetRecord
                .replacingOccurrences(of: "{familyId}", with: familyID)
                .replacingOccurrences(of: "{petId}", with: petID)
                .replacingOccurrences(of: "{recordId}", with: recordID)
            
        case .getNotice:
            return URLs.getNotice
            
        case .postComment(recordID: let recordID, comment: _):
            return URLs.postComment
                .replacingOccurrences(of: "{recordId}", with: recordID)
            
        case .postEmojiComment(recordID: let recordID, emojiID: _):
            return URLs.postEmojiComment
                .replacingOccurrences(of: "{recordId}", with: recordID)
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
            
        case .getDetailPetArchive:
            return .get
            
        case .postEmojiComment:
            return .post
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
            
        case .getDetailPetArchive:
            return .requestPlain
            
        case .getNotice:
            return .requestPlain
            
        case .postComment(recordID: _, comment: let comment):
            let body = HomeCommentReqeust(content: comment)
            return .requestJSONEncodable(body)
            
        case .postEmojiComment(recordID: _, emojiID: let emojiID):
            let body = HomeEmojiCommentReqeust(emoji: emojiID)
            return .requestJSONEncodable(body)
        }
    }
}

