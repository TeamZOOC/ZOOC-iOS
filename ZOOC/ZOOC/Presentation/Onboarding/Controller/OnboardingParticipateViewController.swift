//
//  OnboardingParticipateViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingParticipateViewController: BaseViewController {
    
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
        registerUser()
    }
}

extension OnboardingParticipateViewController {
    func registerUser() {
        guard let code = onboardingParticipateView.familyCodeTextField.text else { return }
        let param = OnboardingRegisterUserRequest(code: code)
        OnboardingAPI.shared.postRegisterUser(requset: param) { result in
            guard let result = self.validateResult(result) as? SimpleResponse else { return }
            
            print(result)
        }
    }
    
    func pushToParticipateCompletedView() {
        let onboardingParticipateCompletedViewController = OnboardingParticipateCompletedViewController()
        self.navigationController?.pushViewController(onboardingParticipateCompletedViewController, animated: true)
    }
}

//MARK: - UITextFieldDelegate

extension OnboardingParticipateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.onboardingParticipateView.nextButton.backgroundColor = .zoocGradientGreen
        self.onboardingParticipateView.nextButton.isEnabled = true
    }
}
