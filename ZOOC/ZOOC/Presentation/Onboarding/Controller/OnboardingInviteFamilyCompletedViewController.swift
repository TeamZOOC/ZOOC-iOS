//
//  OnboardingInviteCompletedFamilyViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

final class OnboardingInviteFamilyCompletedViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingInviteCompletedFamilyView = OnboardingInviteCompletedFamilyView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingInviteCompletedFamilyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingInviteCompletedFamilyView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}





