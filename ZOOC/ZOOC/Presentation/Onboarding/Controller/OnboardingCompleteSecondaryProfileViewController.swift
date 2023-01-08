//
//  OnboardingCompleteSecondaryProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingSecondaryCompleteProfileViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingSecondaryCompleteProfileView = OnboardingSecondaryCompleteProfileView()
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingSecondaryCompleteProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


