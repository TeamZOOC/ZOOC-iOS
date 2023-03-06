//
//  OnboardingParticipateViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingJoinFamilyViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let onboardingParticipateView = OnboardingParticipateView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingParticipateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        target()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingParticipateView.familyCodeTextField.delegate = self
    }
    
    func target() {
        onboardingParticipateView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingParticipateView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonDidTap() {
        requestJoinFamilyAPI()
    }
}

extension OnboardingJoinFamilyViewController {
    private func requestJoinFamilyAPI() {
        guard let code = onboardingParticipateView.familyCodeTextField.text else { return }
        let param = OnboardingJoinFamilyRequest(code: code)
        OnboardingAPI.shared.postJoinFamily(requset: param) { result in
            guard let result = self.validateResult(result) as? OnboardingJoinFamilyResult else { return }
            User.shared.familyID = String(result.familyID)
            self.requestFCMTokenAPI()
        }
    }
    
    private func requestFCMTokenAPI() {
        OnboardingAPI.shared.patchFCMToken(fcmToken: User.shared.fcmToken) { result in
            self.pushToParticipateCompletedView()
            
        }
    }
    
    func pushToParticipateCompletedView() {
        let onboardingParticipateCompletedViewController = OnboardingJoinFamilyCompletedViewController()
        self.navigationController?.pushViewController(onboardingParticipateCompletedViewController, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension OnboardingJoinFamilyViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.onboardingParticipateView.nextButton.backgroundColor = .zoocGradientGreen
        self.onboardingParticipateView.nextButton.isEnabled = true
    }
}
