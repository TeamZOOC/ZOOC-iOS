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
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        onboardingLoginView.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonDidTap), for: .touchUpInside)
        onboardingLoginView.goHomeButton.addTarget(self, action: #selector(goHomeButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc func kakaoLoginButtonDidTap() {
        kakaoSocialLogin()
    }
    
    @objc func goHomeButtonDidTap(){
        changeRootViewController(ZoocTabBarController())
    }
}

private extension OnboardingLoginViewController {
     func kakaoSocialLogin() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            guard let oauthToken = oauthToken else {
                guard let error = error else { return }
                print(error)
                return
            }
            OnboardingAPI.shared.postKakaoSocialLogin(accessToken: "Bearer \(oauthToken.accessToken)") { result in
                guard let result = self.validateResult(result) as? OnboardingTokenData else { return }
                User.jwtToken = result.jwtToken
            }
            self.pushToAgreementView()
        }
    }
    
    func pushToAgreementView() {
        let agreementViewController = OnboardingAgreementViewController()
        self.navigationController?.pushViewController(agreementViewController, animated: true)
    }
}
