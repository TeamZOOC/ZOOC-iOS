//
//  OnboardingParticipateCompletedViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingJoinFamilyCompletedViewController: BaseViewController{
    
    //MARK: - Properties
    
    private let onboardingJoinFamilyCompletedView = OnboardingJoinFamilyCompletedView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingJoinFamilyCompletedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    func target() {
        onboardingJoinFamilyCompletedView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingJoinFamilyCompletedView.startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func startButtonDidTap(){
        let onboardingInviteFamilyCompletedViewController = OnboardingInviteFamilyCompletedViewController()
        self.navigationController?.pushViewController(onboardingInviteFamilyCompletedViewController, animated: true)
    }
}
