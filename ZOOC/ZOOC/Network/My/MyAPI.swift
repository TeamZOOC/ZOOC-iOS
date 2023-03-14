//
//  MyAPI.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit

import Moya

final class MyAPI: BaseAPI {
    static let shared = MyAPI()
    private var myProvider = MoyaProvider<MyService>(plugins: [MoyaLoggingPlugin()])
}

extension MyAPI{
    public func getMyPageData(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.getMyPageData) { (result) in
            self.disposeNetwork(result,
                                dataModel: MyResult.self,
                                completion: completion)
        }
    }
    
    func patchMyProfile(requset: EditProfileRequest,
                        completion: @escaping (NetworkResult<Any>) -> Void){
        myProvider.request(.patchUserProfile(requset)) { result in
            self.disposeNetwork(result,
                                dataModel: UserResult.self,
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
    
    public func registerPet(param: MyRegisterPetRequestDto, completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.postRegisterPet(param: param)) {
            (result) in
            self.disposeNetwork(result,
                                dataModel: [MyRegisterPetResult].self,
                                completion: completion)
        }
    }
    
    public func logout(completion: @escaping (NetworkResult<Any>) -> Void) {
        myProvider.request(.logout) { result in
            self.disposeNetwork(result,
                                dataModel: VoidResult.self,
                                completion: completion)
        }
    }
}
