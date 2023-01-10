//
//  OnboardingCompleteProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingCompleteProfileViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingCompleteProfileView = OnboardingCompleteProfileView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingCompleteProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        updateCompleteProfileView()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingCompleteProfileView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingCompleteProfileView.getCodeButton.addTarget(self, action: #selector(getCodeButtonDidTap), for: .touchUpInside)
        onboardingCompleteProfileView.notGetCodeButton.addTarget(self, action: #selector(notGetCodeButtonDidTap), for: .touchUpInside)
    }
    
    func updateCompleteProfileView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.onboardingCompleteProfileView.completeProfileLabel.textColor = .zoocGray1
            self.onboardingCompleteProfileView.completeProfileSubLabel.isHidden = false
            self.onboardingCompleteProfileView.completeImage.isHidden = false
            self.onboardingCompleteProfileView.getCodeButton.isHidden = false
            self.onboardingCompleteProfileView.notGetCodeButton.isHidden = false
        }
    }
    
    func pushToParticipateCompletedView() {
        let onboardingParticipateViewController = OnboardingParticipateViewController()
        self.navigationController?.pushViewController(onboardingParticipateViewController, animated: true)
    }
    
    func pushToRegisterPetView() {
        let onboardingParticipateViewController = OnboardingRegisterPetViewController()
        self.navigationController?.pushViewController(onboardingParticipateViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func notGetCodeButtonDidTap() {
        pushToParticipateCompletedView()
    }
    
    @objc
    private func getCodeButtonDidTap() {
        pushToRegisterPetView()
    }
}

