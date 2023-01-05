//
//  EditProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class  EditProfileViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var editProfileView = EditProfileView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = editProfileView
        editProfileView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        editProfileView.editCompletedButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
        editProfileView.editProfileImageButton.addTarget(self, action: #selector(chooseProfileImage) , for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        editProfileView.editProfileNameTextField.delegate = self
    }

    
    func dataSend(profileName: String, profileImage: UIImage) {
        editProfileView.editProfileImageButton.setImage(profileImage, for: .normal)
        editProfileView.editProfileNameTextField.placeholder = profileName
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        let myViewController = MyViewController()
        let profileName = editProfileView.editProfileNameTextField.text
        let profileImage = editProfileView.editProfileImageButton.image(for: .normal)
        myViewController.dataSend(profileName: profileName!, profileImage: profileImage!)
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
    
    @objc
    func backButtonDidTap() {
        let alert = UIAlertController(title: "페이지를 나가시겠어요?",
                                      message: "지금 떠나면 내용이 저장되지 않아요",
                                      preferredStyle: UIAlertController.Style.alert)
        let keepText: String = "이어 쓰기"
        //let attributeString = NSMutableAttributedString(string: keepText)
        
        
        let keepAction = UIAlertAction(title: "이어 쓰기", style: .default) { (action) in
            print("ok")
        }
        let backAction = UIAlertAction(title: "나가기", style: .default) { (action) in
            self.popToMyProfileView()
        }
        
        alert.addAction(keepAction)
        alert.addAction(backAction)
        present(alert, animated: true)
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function)
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count <= 10 {
            editProfileView.profileNameCountLabel.text = "\(updatedText.count)/10"
            if updatedText.count > 0 {
                editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocMainGreen //zoocgragreen
                editProfileView.editCompletedButton.backgroundColor = .zoocMainGreen //zoocgragreen
                editProfileView.editCompletedButton.isEnabled = true
            } else {
                editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGray1
                editProfileView.editCompletedButton.backgroundColor = .zoocGray1
                editProfileView.editCompletedButton.isEnabled = false
            }
            return true
        } else {
            editProfileView.profileNameCountLabel.text = "10/10"
            return false
        }
    }
}
