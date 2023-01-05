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
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }

    func dataSend(profileName: String, profileImage: UIImage) {
        editProfileView.editProfileImageButton.setImage(profileImage, for: .normal)
        editProfileView.editProfileNameTextField.placeholder = profileName
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        
        let profileName = editProfileView.editProfileNameTextField.text
        let profileImage = editProfileView.editProfileImageButton.image(for: .normal)
        
        guard let beforeVC = self.navigationController?.previousViewController as? MyViewController else { return }
        beforeVC.dataSend(profileName: profileName!, profileImage: profileImage!)
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
        let myAlertViewController = MyAlertViewController()
        myAlertViewController.modalPresentationStyle = .overFullScreen
        present(myAlertViewController, animated: false)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count > 10 {
                    textField.resignFirstResponder()
                }
                
                if text.count >= 10 {
                    let index = text.index(text.startIndex, offsetBy: 10)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                    editProfileView.profileNameCountLabel.text = "10/10"
                }
                
                else if text.count < 0 {
                    editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGray1
                    editProfileView.editCompletedButton.backgroundColor = .zoocGray1
                    editProfileView.editCompletedButton.isEnabled = false
                    editProfileView.profileNameCountLabel.text = "\(text.count)/10"
                }
                else {
                    editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocMainGreen //zoocgragreen
                    editProfileView.editCompletedButton.backgroundColor = .zoocMainGreen //zoocgragreen
                    editProfileView.editCompletedButton.isEnabled = true
                    editProfileView.profileNameCountLabel.text = "\(text.count)/10"
                }
            }
        }
    }
}
