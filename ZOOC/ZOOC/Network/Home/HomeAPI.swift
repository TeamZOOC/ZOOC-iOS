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
        homeProvider.request(.getTotalArchive(familyID: User.familyID, petID: petID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: [HomeArchiveResult].self,
                                completion: completion)
        }
    }
    
    func getDetailArchive(recordID: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getDetailArchive(familyID: User.familyID, recordID: recordID)) { (result) in
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
}


