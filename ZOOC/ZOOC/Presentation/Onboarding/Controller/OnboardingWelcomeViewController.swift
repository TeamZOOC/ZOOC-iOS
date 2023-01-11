//
//  OnboardingWelcomeViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class OnboardingWelcomeViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingWelcomeView = OnboardingWelcomeView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingWelcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        updateWelcomeView()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        onboardingWelcomeView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingWelcomeView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    private func updateWelcomeView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.onboardingWelcomeView.welcomeLabel.textColor = .zoocGray1
            self.onboardingWelcomeView.welcomeSubLabel.isHidden = false
            self.onboardingWelcomeView.welcomeImage.isHidden = false
            self.onboardingWelcomeView.nextButton.isHidden = false
        }
    }
    
    private func pushToChooseFamilyRoleView() {
        let onboardingChooseFamilyRoleViewController = OnboardingChooseFamilyRoleViewController()
        self.navigationController?.pushViewController(onboardingChooseFamilyRoleViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func nextButtonDidTap() {
        pushToChooseFamilyRoleView()
    }
}

