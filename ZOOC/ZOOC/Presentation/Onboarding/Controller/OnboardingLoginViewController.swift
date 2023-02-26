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

//enum KakaoLogin {
//    case kakaoTalk
//    case kakaoAccount
//
////    func loginKakao() async -> Bool {
////        var success: Bool = false
////        switch self {
////        case .kakaoTalk:
////            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
////                guard let oauthToken = oauthToken else {
////                    guard let error = error else { return }
////                    print(error)
////                    return
////                }
////                self.postKakaoSocialLogin(oauthToken: oauthToken)
////            }
////
////        case .kakaoAccount:
////            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
////                guard let oauthToken = oauthToken else {
////                    guard let error = error else { return }
////                    print(error)
////                    return
////                }
////                self.postKakaoSocialLogin(oauthToken: oauthToken)
////            }
////        }
////        success = User.jwtToken != "" ? true : false
////        return success
////    }
////
////    func postKakaoSocialLogin(oauthToken: OAuthToken) {
////        OnboardingAPI.shared.postKakaoSocialLogin(accessToken: "Bearer \(oauthToken.accessToken)") { result in
////            switch result {
////            case .success(let data):
////                guard let data = data as? OnboardingTokenData else { return}
////                User.jwtToken = data.jwtToken
////            case .requestErr(let message):
////                print(message)
////            case .decodedErr:
////                print("디코딩 오류가 발생했습니다.")
////            case .pathErr:
////                print("잘못된 경로입니다.")
////            case .serverErr:
////                print("서버 오류 혹은 메소드 오류입니다.")
////            case .networkFail:
////                print("네트워크가 불안정합니다.")
////            }
////        }
////    }
////}

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
    //    func kakaoSocialLogin() {
    ////        let kakaoLogin: KakaoLogin
    ////        kakaoLogin = UserApi.isKakaoTalkLoginAvailable() ? .kakaoTalk : .kakaoAccount
    ////        if kakaoLogin.loginKakao() {
    ////            print(true)
    ////            self.pushToAgreementView()
    ////        } else {
    ////            print(false)
    ////        }
    //
    //    }
    func kakaoSocialLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                guard let oauthToken = oauthToken else {
                    guard let error = error else { return }
                    print(error)
                    return
                }
                self.postKakaoSocialLogin(oauthToken: oauthToken)
                self.pushToAgreementView()
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                guard let oauthToken = oauthToken else {
                    guard let error = error else { return }
                    print(error)
                    return
                }
                self.postKakaoSocialLogin(oauthToken: oauthToken)
                self.pushToAgreementView()
            }
        }
    }
    
    func postKakaoSocialLogin(oauthToken: OAuthToken) {
        OnboardingAPI.shared.postKakaoSocialLogin(accessToken: "Bearer \(oauthToken.accessToken)") { result in
            guard let result = self.validateResult(result) as? OnboardingTokenData else { return }
            User.jwtToken = result.jwtToken
        }
    }
    
    func pushToAgreementView() {
        let agreementViewController = OnboardingAgreementViewController(onboardingAgreementViewModel: OnboardingAgreementViewModel())
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
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                //                let authorizationCodeString = String(data: authorizationCode, encoding: .utf8),
                let identityTokenString = String(data: identityToken, encoding: .utf8) {
                //                print("authorizationCode: \(authorizationCode)")
                //                print("identityToken: \(identityToken)")
                //                print("authorizationCodeString: \(authorizationCodeString)")
                print("identityTokenString: \(identityTokenString)")
                OnboardingAPI.shared.postAppleSocialLogin(param: OnboardingAppleSocailLoginRequestDto(identityTokenString: identityTokenString)) { result in
                    guard let result = self.validateResult(result) as? OnboardingTokenData else { return }
                    User.jwtToken = result.jwtToken
                    print("드디어 받아온 jwt 토큰 \(User.jwtToken)")
                }
                self.pushToAgreementView()
            }
            //            print("User ID : \(userIdentifier)")
            //            print("User Email : \(email ?? "")")
            //            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

