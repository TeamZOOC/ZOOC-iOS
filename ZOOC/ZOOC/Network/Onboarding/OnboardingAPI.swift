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
        onboardingProvider.request(.getInviteCode(familyId: familyID)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingInviteResult.self,
                                completion: completion)
        }
    }
    
    public func postRegisterUser(requset: OnboardingRegisterUserRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postRegisterUser(requset)) { (result) in
            self.disposeNetwork(result,
                                dataModel: SimpleResponse.self,
                                completion: completion)
        }
    }
    
    public func postRegisterPet(request: OnboardingRegisterPetRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postRegisterPet(request)) { (result) in
            self.disposeNetwork(result,
                                dataModel: [OnboardingRegisterPetResult].self,
                                completion: completion)
        }
    }
    
    public func postKakaoSocialLogin(accessToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postKakaoSocialLogin(accessToken: accessToken)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingJWTTokenResult.self,
                                completion: completion)
        }
    }
    
    public func postAppleSocialLogin(request: OnboardingAppleSocialLoginRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.postAppleSocialLogin(request)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingJWTTokenResult.self,
                                completion: completion)
        }
    }
    
    public func getFamily(completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.getFamily) {(result) in
            self.disposeNetwork(result,
                                dataModel: [OnboardingFamilyResult].self,
                                completion: completion)
        }
    }
    
    
}
