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
    
    //MARK: - UI Components
    
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
    }
    
    
    
    //MARK: - Action Method
    
    @objc
    private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count >= 10 {
                    print("10 이상상상상상상상상")
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
                    print("yes")
                    onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = false
                }
                else {
                    print("no")
                    onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocDarkGreen
                    onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocDarkGreen
                    onboardingChooseFamilyRoleView.chooseFamilyButton.backgroundColor = .zoocGray1
                    onboardingChooseFamilyRoleView.chooseFamilyButton.isEnabled = false
                }
            }
        }
    }
    
//    @objc
//    private pushTo
}


