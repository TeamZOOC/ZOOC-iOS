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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        presentToWelcomeView2()
    }
    
    //MARK: - Custom Method
    
    func presentToWelcomeView2() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let secondaryWelcomeViewController = OnboardingWelcomeSecondaryViewController()
            self.navigationController?.pushViewController(secondaryWelcomeViewController, animated: true)
        }
    }
}

