//
//  OnboardingCompleteSecondaryProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingSecondaryCompleteProfileViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingSecondaryCompleteProfileView = OnboardingSecondaryCompleteProfileView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingSecondaryCompleteProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register ()
    }
    
    //MARK: - Custom Method
    
    func register () {
        onboardingSecondaryCompleteProfileView.backButton.addTarget(self, action: #selector(popToCompleteProfileView), for: .touchUpInside)
        
        onboardingSecondaryCompleteProfileView.notGetCodeButton.addTarget(self, action: #selector(notGetCodeButtonDidTap), for: .touchUpInside)
    }
    
    func pushToParticipateCompletedView() {
        let onboardingParticipateCompletedViewController = OnboardingParticipateCompletedViewController()
        self.navigationController?.pushViewController(onboardingParticipateCompletedViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToCompleteProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func notGetCodeButtonDidTap() {
        pushToParticipateCompletedView()
    }
}


