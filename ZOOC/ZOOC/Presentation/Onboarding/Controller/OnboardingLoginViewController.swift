//
//  OnboardingLoginViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class OnboardingLoginViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingLoginView = OnboardingLoginView()
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingLoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
