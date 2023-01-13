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

extension OnboardingAPI{
    func registerUser(param: OnboardingRegisterUserRequestDto, completion: @escaping (NetworkResult<Any>) -> Void) {
        onboardingProvider.request(.registerUser(param: param)) { (result) in
            self.disposeNetwork(result,
                                dataModel: OnboardingResult.self,
                                completion: completion)
        }
    }
}


