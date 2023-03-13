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
    private var registerMyProfileData = EditProfileRequest(hasPhoto: false)
    
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
        
        onboardingChooseFamilyRoleView.chooseFamilyButton.addTarget(self, action: #selector(chooseFamilyButtonDidTap), for: .touchUpInside)
        onboardingChooseFamilyRoleView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func textDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard let text = textField.text else { return }
        var textFieldState: BaseTextFieldState
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
        
        textFieldState.setTextFieldState(
            textField: onboardingChooseFamilyRoleView.chooseFamilyTextField,
            underLineView: onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView,
            button: onboardingChooseFamilyRoleView.chooseFamilyButton
        )
    }
    
    @objc private func chooseFamilyButtonDidTap() {
        registerMyProfileData.nickName = onboardingChooseFamilyRoleView.chooseFamilyTextField.text!
        MyAPI.shared.patchMyProfile(requset: registerMyProfileData) { result in
            //guard let result = self.validateResult(result) as? UserResult else { return }
            self.pushToCompleteProfileView()
        }
    }
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OnboardingChooseFamilyRoleViewController {
    func pushToCompleteProfileView() {
        let onboardingCompleteProfileViewController = OnboardingCompleteProfileViewController()
        self.navigationController?.pushViewController(onboardingCompleteProfileViewController, animated: true)
    }
}

