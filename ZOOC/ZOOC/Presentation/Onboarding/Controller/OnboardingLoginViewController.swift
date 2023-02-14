//
//  OnboardingLoginViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import AuthenticationServices
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

//extension OnboardingLoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
//    
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//    
//    // Apple ID 연동 성공 시
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//            // Apple ID
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            
//            // 계정 정보 가져오기
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//            let idToken = appleIDCredential.identityToken!
//            let tokeStr = String(data: idToken, encoding: .utf8)
//         
//            print("User ID : \(userIdentifier)")
//            print("User Email : \(email ?? "")")
//            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
//            print("token : \(String(describing: tokeStr))")
//            
//        default:
//            break
//        }
//    }
//    
//    // Apple ID 연동 실패 시
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        // Handle error.
//    }
//}
