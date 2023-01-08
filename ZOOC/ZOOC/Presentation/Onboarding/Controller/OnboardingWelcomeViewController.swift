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
        
        onboardingWelcomeView.backButton.addTarget(self, action: #selector(popToLoginView), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        pushToSecondaryWelcomeView()
    }
    
    //MARK: - Custom Method
    
    func pushToSecondaryWelcomeView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let secondaryWelcomeViewController = OnboardingWelcomeSecondaryViewController()
            self.navigationController?.pushViewController(secondaryWelcomeViewController, animated: true)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToLoginView() {
        self.navigationController?.popViewController(animated: true)
    }
}

