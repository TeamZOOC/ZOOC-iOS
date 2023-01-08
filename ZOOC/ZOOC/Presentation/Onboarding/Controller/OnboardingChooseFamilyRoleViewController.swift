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
        
        chooseFamilyTextFieldisFocused()
    }
    
    //MARK: - Custom Method
    
    func chooseFamilyTextFieldisFocused() {
        if onboardingChooseFamilyRoleView.chooseFamilyTextField.isFocused {
            onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocDarkGreen
            onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocDarkGreen
        } else {
            onboardingChooseFamilyRoleView.chooseFamilyTextFeildUnderLineView.backgroundColor = .zoocGray1
            onboardingChooseFamilyRoleView.chooseFamilyTextField.textColor = .zoocGray1
        }
        
    }
    
    //MARK: - Action Method
    
}
