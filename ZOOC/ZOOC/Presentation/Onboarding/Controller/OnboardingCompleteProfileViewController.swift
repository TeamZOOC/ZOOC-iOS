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
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingCompleteProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingCompleteProfileView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        pushToSecondaryCompleteProfileView()
    }
    
    //MARK: - Custom Method
    
    func pushToSecondaryCompleteProfileView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let secondaryCompleteProfileViewController = OnboardingSecondaryCompleteProfileViewController()
            self.navigationController?.pushViewController(secondaryCompleteProfileViewController, animated: true)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

