//
//  OnboardingReInviteFamilyViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

final class OnboardingReInviteFamilyViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingReInviteFamilyView = OnboardingReInviteFamilyView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingReInviteFamilyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingReInviteFamilyView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        onboardingReInviteFamilyView.inviteButton.addTarget(self, action: #selector(inviteButtonDidTap), for: .touchUpInside)
    }
    
    private func pushToInviteCompletedFamilyView() {
        let onboardingInviteCompletedFamilyViewController = OnboardingInviteFamilyCompletedViewController()
        self.navigationController?.pushViewController(onboardingInviteCompletedFamilyViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func inviteButtonDidTap() {
        pushToInviteCompletedFamilyView()
    }
}
