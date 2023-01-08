//
//  OnboardingSecondaryWelcomeViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

final class OnboardingWelcomeSecondaryViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingSecondaryWelcomeView = OnboardingSecondaryWelcomeView()
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingSecondaryWelcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
