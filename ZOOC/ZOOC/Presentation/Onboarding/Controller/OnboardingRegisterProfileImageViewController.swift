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
        
        register()
        
        let attributtedString = NSMutableAttributedString(string: familyRoleLabel)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.zoocGradientGreen, range: (familyRoleLabel as NSString).range(of: profileName))
                
        onboardingRegisterProfileImageView.registerProfileImageLabel.attributedText = attributtedString
     
    }
    
    //MARK: - Custom Method
    
    private func register() {
        onboardingRegisterProfileImageView.createProfileButton.addTarget(self, action: #selector(createProfileButtonDidTap), for: .touchUpInside)
        
        onboardingRegisterProfileImageView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        onboardingRegisterProfileImageView.registerProfileImageButton.addTarget(self, action: #selector(chooseProfileImage), for: .touchUpInside)
    }
    
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
    
    @objc
    func chooseProfileImage() {
        let actionSheetController = UIAlertController()
        
        let presentToGalleryButton = UIAlertAction(title: "사진 보관함", style: .default, handler: {action in
            print("ok")
        })
        
        let deleteProfileImageButton = UIAlertAction(title: "사진 삭제", style: .destructive, handler: {action in
            print("delete")
        })
        
        let cancleButton = UIAlertAction(title: "취소", style: .cancel, handler: {action in
            print("cancel")
        })
        
        actionSheetController.addAction(presentToGalleryButton)
        actionSheetController.addAction(deleteProfileImageButton)
        actionSheetController.addAction(cancleButton)
        self.present(actionSheetController, animated: true)
    }
}
