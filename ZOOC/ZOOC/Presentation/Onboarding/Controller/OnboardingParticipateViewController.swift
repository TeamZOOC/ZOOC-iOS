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
        let param = OnboardingRegisterUserRequestDto(code: code)
        OnboardingAPI.shared.registerUser(param: param) { result in
            switch result {
            case .success(_):
                self.pushToParticipateCompletedView()
            case .requestErr(let message):
                self.onboardingParticipateView.nextButton.isEnabled = false
                self.onboardingParticipateView.nextButton.backgroundColor = .zoocGray1
                self.presentBottomAlert(message)
            case .decodedErr:
                break
            case .pathErr:
                break
            case .serverErr:
                break
            case .networkFail:
                break
            }
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




