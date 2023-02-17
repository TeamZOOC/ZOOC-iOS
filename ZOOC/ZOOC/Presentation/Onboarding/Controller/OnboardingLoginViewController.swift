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
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
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
        } else {
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
    }
    
    func pushToAgreementView() {
        let agreementViewController = OnboardingAgreementViewController()
        self.navigationController?.pushViewController(agreementViewController, animated: true)
    }
}

extension OnboardingLoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func appleSocialLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        
        
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authorizationCodeString = String(data: authorizationCode, encoding: .utf8),
                let identityTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authorizationCodeString: \(authorizationCodeString)")
                print("identityTokenString: \(identityTokenString)")
                
            }
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
