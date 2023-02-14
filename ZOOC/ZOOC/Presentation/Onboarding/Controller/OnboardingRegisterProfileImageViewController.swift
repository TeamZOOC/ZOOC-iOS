//
//  OnboardingRegisterProfileImageViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterProfileImageViewController: BaseViewController{
    
    //MARK: - Properties
    
    var isPhoto: Bool = false
    var image: UIImage?
    
    private var profileName: String = ""
    private var familyRoleLabel: String = ""
    private let onboardingRegisterProfileImageView = OnboardingRegisterProfileImageView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingRegisterProfileImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardNotifications()
    }
    
    //MARK: - Custom Method
    
    private func style() {
        let attributtedString = NSMutableAttributedString(string: familyRoleLabel)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                       value: UIColor.zoocGradientGreen,
                                       range: (familyRoleLabel as NSString).range(of: "\(profileName)!"))
                
        onboardingRegisterProfileImageView.registerProfileImageLabel.attributedText = attributtedString
    }
    
    private func target() {
        onboardingRegisterProfileImageView.createProfileButton.addTarget(self, action: #selector(createProfileButtonDidTap), for: .touchUpInside)
        onboardingRegisterProfileImageView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingRegisterProfileImageView.registerProfileImageButton.addTarget(self, action: #selector(chooseProfileImage), for: .touchUpInside)
    }
    
    func dataSend(profileName: String) {
        self.familyRoleLabel = "\(profileName)! \n프로필 사진을 등록할까요?"
        self.profileName = "\(profileName)"
    }
    
    //MARK: - Action Method
    
    @objc func createProfileButtonDidTap() {
        onboardingRegisterProfileImageView.createProfileButton.isEnabled = false
        onboardingRegisterProfileImageView.createProfileButton.backgroundColor = .zoocGray1
        MyAPI.shared.patchMyProfile(isPhoto: isPhoto,
                                    nickName: profileName,
                                    photo: image)
        { result in
            print(result)
            guard let result = self.validateResult(result) as? MyUser else { return }
            self.pushToCompleteProfileView()
        }
    }
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func chooseProfileImage() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
    }
}

extension OnboardingRegisterProfileImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        isPhoto = true
        self.image = image
        onboardingRegisterProfileImageView.registerProfileImageButton.setImage(image, for: .normal)
    }
}

private extension OnboardingRegisterProfileImageViewController {
    func pushToCompleteProfileView() {
        let onboardingCompleteProfileViewController = OnboardingCompleteProfileViewController()
        self.navigationController?.pushViewController(onboardingCompleteProfileViewController, animated: true)
    }
}
