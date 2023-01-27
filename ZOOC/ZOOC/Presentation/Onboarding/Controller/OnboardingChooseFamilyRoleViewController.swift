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
        switch text.count {
        case 1...9:
            textFieldIsWritten()
        case 10...:
            textField.resignFirstResponder()
            let index = text.index(text.startIndex, offsetBy: 10)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
            textFieldIsFull()
        default:
            textFieldIsEmpty()
        }
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

extension OnboardingChooseFamilyRoleViewController {
    func textFieldIsFull() {
        onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocGray1
        onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocDarkGreen
        onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGradientGreen
        onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = true
    }
    
    func textFieldIsEmpty() {
        onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocGray1
        onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocGray1
        onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGray1
        onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = false
    }
    
    func textFieldIsWritten() {
        onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocDarkGreen
        onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocDarkGreen
        onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGray1
        onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGradientGreen
        onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = true
    }
}
