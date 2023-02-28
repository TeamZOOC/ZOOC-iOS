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
    
    private var registerMyProfileData = EditProfileRequest(hasPhoto: false)
    private var familyRoleLabel: String = ""
    
    //MARK: - UI Components
    
    private let rootView = OnboardingRegisterProfileImageView()
    private let imagePickerController = UIImagePickerController()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        delegate()
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
    
    private func delegate() {
        imagePickerController.delegate = self
    }
    
    private func style() {
        let attributtedString = NSMutableAttributedString(string: familyRoleLabel)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                       value: UIColor.zoocGradientGreen,
                                       range: (familyRoleLabel as NSString).range(of: "\(registerMyProfileData.nickName)!"))
                
        rootView.registerProfileImageLabel.attributedText = attributtedString
        
        imagePickerController.do {
            $0.sourceType = .photoLibrary
        }
    }
    
    private func target() {
        rootView.createProfileButton.addTarget(self, action: #selector(createProfileButtonDidTap), for: .touchUpInside)
        rootView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        rootView.registerProfileImageButton.addTarget(self, action: #selector(chooseProfileImage), for: .touchUpInside)
    }
    
    func dataBind(nickName: String) {
        registerMyProfileData.nickName = nickName
        familyRoleLabel = "\(nickName)! \n프로필 사진을 등록할까요?"
    }
    
    private func requestRegisterProfileAPI() {
        MyAPI.shared.patchMyProfile(requset: registerMyProfileData) { result in
            //guard let result = self.validateResult(result) as? UserResult else { return }
            self.pushToCompleteProfileView()
        }
    }
    
    //MARK: - Action Method
    
    @objc func createProfileButtonDidTap() {
        rootView.createProfileButton.isEnabled = false
        rootView.createProfileButton.backgroundColor = .zoocGray1
        requestRegisterProfileAPI()
    }
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func chooseProfileImage() {
        present(imagePickerController, animated: true)
    }
}

extension OnboardingRegisterProfileImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        registerMyProfileData.hasPhoto = true
        registerMyProfileData.profileImage = image
        rootView.registerProfileImageButton.setImage(image, for: .normal)
        dismiss(animated: true)
    }
}

private extension OnboardingRegisterProfileImageViewController {
    func pushToCompleteProfileView() {
        let onboardingCompleteProfileViewController = OnboardingCompleteProfileViewController()
        self.navigationController?.pushViewController(onboardingCompleteProfileViewController, animated: true)
    }
}
