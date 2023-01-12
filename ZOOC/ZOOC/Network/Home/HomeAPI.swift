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
    
    public func getTotalPet(familyID: String ,completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getTotalPet(familyID: familyID)) { (result) in
            self.disposeNetwork(result, dataModel: [PetResult].self, completion: completion)
        }
    }
    
    func getTotalArchive(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getTotalArchive(familyID: User.familyID)) { (result) in
            self.disposeNetwork(result, dataModel: [HomeArchiveResult].self, completion: completion)
        }
    }
}


