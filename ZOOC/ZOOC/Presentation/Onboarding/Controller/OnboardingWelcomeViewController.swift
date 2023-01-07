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
    private let onboardingWelcome2View = OnboardingWelcome2View()
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingWelcome2View
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

