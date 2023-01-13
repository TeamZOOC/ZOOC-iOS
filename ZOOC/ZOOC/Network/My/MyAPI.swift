//
//  MyAPI.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

import Moya

final class MyAPI: BaseAPI {
    static let shared = MyAPI()
    private var myProvider = MoyaProvider<MyService>(plugins: [MoyaLoggingPlugin()])
}

extension MyAPI{
    func getMyPageData(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getMyPageData) { (result) in
            self.disposeNetwork(result,
                                dataModel: MyResult.self,
                                completion: completion)
        }
    }
    
    func deleteAccount(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.deleteAccount) { (result) in
            self.disposeNetwork(result,
                                dataModel: MyResult.self,
                                completion: completion)
        }
    }
}
