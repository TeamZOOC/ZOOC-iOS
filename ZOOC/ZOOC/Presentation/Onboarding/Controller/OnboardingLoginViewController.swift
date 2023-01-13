//
//  OnboardingLoginViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import KakaoSDKAuth
import KakaoSDKUser
import SnapKit
import Then

final class OnboardingLoginViewController: BaseViewController{
    
    //MARK: - Properties
    
    private let onboardingLoginView = OnboardingLoginView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingLoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingLoginView.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
    }
    
    func pushToAgreementView() {
        let agreementViewController = OnboardingAgreementViewController()
        self.navigationController?.pushViewController(agreementViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    func kakaoLoginButtonDidTap() {
        print("yes")
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                if let oauthToken = oauthToken {
                    OnboardingAPI.shared.postKakaoSocialLogin(accessToken: "Bearer \(oauthToken.accessToken)") { result in
                        print("❤️\(result)")
                        guard let result = self.validateResult(result) as? OnboardingResult else { return }
                        print("💚\(result)")
                        
                    }
//                    self.pushToAgreementView()
                }
            }
        }
        
    }
}
