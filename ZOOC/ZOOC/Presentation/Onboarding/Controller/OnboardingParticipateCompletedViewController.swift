//
//  OnboardingParticipateCompletedViewController.swift
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
        
        target()
    }
    
    //MARK: - Custom Method
    
    func target() {
        onboardingParticipateCompletedView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingParticipateCompletedView.startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func startButtonDidTap(){
        changeRootViewController(ZoocTabBarController())
    }
}
