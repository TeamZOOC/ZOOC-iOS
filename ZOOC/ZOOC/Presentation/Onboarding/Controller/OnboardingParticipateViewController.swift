//
//  OnboardingParticipateViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingParticipateViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingParticipateView = OnboardingParticipateView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingParticipateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingParticipateView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        onboardingParticipateView.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    func pushToParticipateCompletedView() {
        let onboardingParticipateCompletedViewController = OnboardingParticipateCompletedViewController()
        self.navigationController?.pushViewController(onboardingParticipateCompletedViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonDidTap() {
        pushToParticipateCompletedView()
    }
}




