//
//  OnboardingRegisterProfileImageViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterProfileImageViewController: UIViewController{
    
    //MARK: - Properties
    private var profileName: String = ""
    private var familyRoleLabel: String = ""
    private let onboardingRegisterProfileImageView = OnboardingRegisterProfileImageView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingRegisterProfileImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingRegisterProfileImageView.createProfileButton.addTarget(self, action: #selector(createProfileButtonDidTap), for: .touchUpInside)
        
        let attributtedString = NSMutableAttributedString(string: familyRoleLabel)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.zoocGradientGreen, range: (familyRoleLabel as NSString).range(of: profileName))
                
        onboardingRegisterProfileImageView.registerProfileImageLabel.attributedText = attributtedString
        onboardingRegisterProfileImageView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Custom Method
    
    private func pushToCompleteProfileView() {
        let onboardingCompleteProfileViewController = OnboardingCompleteProfileViewController()
        self.navigationController?.pushViewController(onboardingCompleteProfileViewController, animated: true)
    }
    
    func dataSend(profileName: String) {
        self.familyRoleLabel = "\(profileName)! \n프로필 사진을 등록할까요?"
        self.profileName = "\(profileName)!"
    }
    
    //MARK: - Action Method
    
    @objc
    func createProfileButtonDidTap() {
        pushToCompleteProfileView()
    }
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
