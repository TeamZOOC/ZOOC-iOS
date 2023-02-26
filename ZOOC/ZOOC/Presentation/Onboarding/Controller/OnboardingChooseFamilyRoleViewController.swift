//
//  OnboardingChooseFamilyRoleViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/08.
//

import UIKit

import SnapKit
import Then



final class OnboardingChooseFamilyRoleViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingChooseFamilyRoleView = OnboardingChooseFamilyRoleView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingChooseFamilyRoleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Custom Method
    
    func target() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
        
        onboardingChooseFamilyRoleView.chooseFamilyButton.addTarget(self, action: #selector(pushToRegisterProfileImageView), for: .touchUpInside)
        onboardingChooseFamilyRoleView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func textDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard let text = textField.text else { return }
        var textFieldState: TextFieldState
        switch text.count {
        case 1...9:
            textFieldState = .isWritten
        case 10...:
            textFieldState = .isFull
            textField.resignFirstResponder()
            let index = text.index(text.startIndex, offsetBy: 10)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
        default:
            textFieldState = .isEmpty
        }
        setTextFieldState(textFieldState: textFieldState)
    }
    
    @objc private func pushToRegisterProfileImageView() {
        let onboardingRegisterProfileImageViewController = OnboardingRegisterProfileImageViewController()
        let profileName = onboardingChooseFamilyRoleView.chooseFamilyTextField.text!
        onboardingRegisterProfileImageViewController.dataSend(profileName: profileName)
        self.navigationController?.pushViewController(onboardingRegisterProfileImageViewController, animated: true)
    }
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

private extension OnboardingChooseFamilyRoleViewController {
    func setTextFieldState(textFieldState: TextFieldState) {
        onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = textFieldState.backgroundColor
        onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = textFieldState.textColor
        onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = textFieldState.buttonColor
        onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = textFieldState.isEnabled
    }
}

enum TextFieldState {
    case isFull
    case isEmpty
    case isWritten
    
    var backgroundColor: UIColor {
        switch self {
        case .isFull:
            return .zoocGray1
        case .isEmpty:
            return .zoocGray1
        case .isWritten:
            return .zoocDarkGreen
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .isFull:
            return .zoocDarkGreen
        case .isEmpty:
            return .zoocGray1
        case .isWritten:
            return .zoocDarkGreen
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .isFull:
            return .zoocGradientGreen
        case .isEmpty:
            return .zoocGray1
        case .isWritten:
            return .zoocGradientGreen
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .isFull:
            return true
        case .isEmpty:
            return false
        case .isWritten:
            return true
        }
    }
}

