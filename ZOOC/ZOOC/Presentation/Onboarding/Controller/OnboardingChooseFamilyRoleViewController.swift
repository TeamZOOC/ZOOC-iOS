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
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
        
        onboardingChooseFamilyRoleView.chooseFamilyButton.addTarget(self, action: #selector(pushToRegisterProfileImageView), for: .touchUpInside)
        onboardingChooseFamilyRoleView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc
    private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count >= 10 {
                    textField.resignFirstResponder()
                    let index = text.index(text.startIndex, offsetBy: 10)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                    onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocDarkGreen
                    onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGradientGreen
                    onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = true
                }
                else if text.count <= 0 {
                    onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = false
                }
                else {
                    onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocDarkGreen
                    onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocDarkGreen
                    onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGradientGreen
                    onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = true
                }
            }
        }
    }
    
    @objc
    private func pushToRegisterProfileImageView() {
        let onboardingRegisterProfileImageViewController = OnboardingRegisterProfileImageViewController()
        let profileName = onboardingChooseFamilyRoleView.chooseFamilyTextField.text!
        onboardingRegisterProfileImageViewController.dataSend(profileName: profileName)
        self.navigationController?.pushViewController(onboardingRegisterProfileImageViewController, animated: true)
    }
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}


