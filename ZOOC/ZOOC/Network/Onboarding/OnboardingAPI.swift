//
//  OnboardingAPI.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit
import Moya

class OnboardingAPI: BaseAPI {
    static let shared = OnboardingAPI()
    var onboardingProvider = MoyaProvider<OnboardingService>(plugins: [MoyaLoggingPlugin()])
}

extension OnboardingAPI {
    public func getInviteCode(familyID: String ,completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.getInviteCode(familyId: familyID)) {
            (result) in self.disposeNetwork(result, dataModel: OnboardingInviteResult.self, completion: completion)
        }
    }
    
    public func registerUser(param: OnboardingRegisterUserRequestDto, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postRegisterUser(param: param)) { (result) in
            self.disposeNetwork(result,
                                dataModel: SimpleResponse.self,
                                completion: completion)
        }
    }
    
    public func registerPet(petNames: [String], files: [UIImage], completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postRegisterPet(petNames: petNames, files: files)) {
            (result) in
            self.disposeNetwork(result,
                                dataModel: [OnboardingRegisterPetResult].self,
                                completion: completion)
        }
    }
    
    public func postKakaoSocialLogin(accessToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postKakaoSocialLogin(accessToken: accessToken)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingTokenData.self,
                                completion: completion)
        }
    }
}
