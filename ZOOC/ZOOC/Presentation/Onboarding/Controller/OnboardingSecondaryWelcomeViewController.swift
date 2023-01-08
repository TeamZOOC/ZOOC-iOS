//
//  OnboardingSecondaryWelcomeViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

final class OnboardingWelcomeSecondaryViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingSecondaryWelcomeView = OnboardingSecondaryWelcomeView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingSecondaryWelcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        onboardingSecondaryWelcomeView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        onboardingSecondaryWelcomeView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private func pushToChooseFamilyRoleView() {
        let onboardingChooseFamilyRoleViewController = OnboardingChooseFamilyRoleViewController()
        self.navigationController?.pushViewController(onboardingChooseFamilyRoleViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    func nextButtonDidTap() {
        pushToChooseFamilyRoleView()
    }
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
