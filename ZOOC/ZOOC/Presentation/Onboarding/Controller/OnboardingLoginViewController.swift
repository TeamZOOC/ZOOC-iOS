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

final class OnboardingLoginViewController: BaseViewController {
    
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
        onboardingLoginView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc func kakaoLoginButtonDidTap() {
        kakaoSocialLogin()
    }
    
    @objc func appleLoginButtonDidTap() {
        appleSocialLogin()
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

extension OnboardingLoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    /// 버튼을 눌렀을때 Apple 로그인을 모달 시트로 표시하는 함수입니다.
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    /// 생성한 버튼을 눌렀을때 행동을 설정해줍니다.
    /// 요청으로 얻을 수 있는 값은 이름과 이메일이 있습니다.
    func appleSocialLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
                
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")

        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
