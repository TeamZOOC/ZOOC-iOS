//
//  OnboardingParticipateViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingParticipateCompletedViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingParticipateCompletedView = OnboardingParticipateCompletedView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingParticipateCompletedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    func register() {
        onboardingParticipateCompletedView.backButton.addTarget(self, action: #selector(popToSecondaryCompleteProfileView), for: .touchUpInside)
    }
    
    @objc
    private func popToSecondaryCompleteProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
}




