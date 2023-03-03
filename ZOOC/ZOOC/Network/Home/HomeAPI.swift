//
//  HomeAPI.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit
import Moya

class HomeAPI: BaseAPI {
    static let shared = HomeAPI()
    var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    
}

extension HomeAPI{
    
    public func getMission(familyID: String ,completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getMission(familyID: familyID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: [HomeMissionResult].self,
                                completion: completion)
        }
    }
    
    public func getTotalPet(familyID: String ,completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getTotalPet(familyID: familyID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: [HomePetResult].self,
                                completion: completion)
        }
    }
    
    func getTotalArchive(petID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getTotalArchive(familyID: User.shared.familyID, petID: petID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: [HomeArchiveResult].self,
                                completion: completion)
        }
    }
    
    func getDetailArchive(recordID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getDetailArchive(familyID: User.shared.familyID, recordID: recordID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: HomeDetailArchiveResult.self,
                                completion: completion)
        }
    } //아마 사용안함
    
    func getDetailPetArchive(recordID: String, petID: String ,completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getDetailPetArchive(familyID: User.shared.familyID, recordID: recordID, petID: petID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: HomeDetailArchiveResult.self,
                                completion: completion)
        }
    }
            
    func getNotice(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getNotice) { (result) in
            self.disposeNetwork(result, dataModel: [HomeNoticeResult].self, completion: completion)
        }
    }
    
    func postComment(recordID: String, comment: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.postComment(recordID: recordID, comment: comment)) { (result) in
            self.disposeNetwork(result, dataModel: [CommentResult].self, completion: completion)
        }
    }
    
    func postEmojiComment(recordID: String, emojiID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.postEmojiComment(recordID: recordID, emojiID: emojiID)) { (result) in
            self.disposeNetwork(result, dataModel: [CommentResult].self, completion: completion)
        }
    }
    
    
}


