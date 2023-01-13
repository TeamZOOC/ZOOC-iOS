//
//  EditProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class EditProfileViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var editProfileView = EditProfileView()
    private var myProfileData: MyUser?
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    
    //MARK: - Custom Method
    
    func register() {
        editProfileView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        editProfileView.editCompletedButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
        editProfileView.editProfileImageButton.addTarget(self, action: #selector(chooseProfileImage) , for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }

    func dataSend(data: MyUser?) {
        if data?.photo == nil {
            editProfileView.editProfileImageButton.setImage(Image.defaultProfile, for: .normal)
        } else {
            editProfileView.editProfileImageButton.kf.setImage(with: URL(string: (data?.photo)!), for: .normal)
        }
        
        editProfileView.editProfileNameTextField.placeholder = data?.nickName
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        
        let profileName = editProfileView.editProfileNameTextField.text
        let profileImage = editProfileView.editProfileImageButton.image(for: .normal)
        
        guard let beforeVC = self.navigationController?.previousViewController as? MyViewController else { return }
        beforeVC.dataSend(myprofileData: myProfileData)
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
        let myAlertViewController = ZoocAlertViewController()
        myAlertViewController.modalPresentationStyle = .overFullScreen
        present(myAlertViewController, animated: false)
    }
    
    @objc
    private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count >= 10 {
                    textField.resignFirstResponder()
                    let index = text.index(text.startIndex, offsetBy: 10)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                    textCountOver()
                }
                else if text.count <= 0 {
                    textCountUnder(textCount: text.count)
                }
                else {
                    textWriting(textCount: text.count)
                }
            }
        }
    }
}

extension EditProfileViewController {
    func textCountOver() {
        editProfileView.profileNameCountLabel.text = "10/10"
    }
    
    func textWriting(textCount: Int) {
        editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGradientGreen
        editProfileView.editCompletedButton.backgroundColor = .zoocGradientGreen
        editProfileView.editCompletedButton.isEnabled = true
        editProfileView.profileNameCountLabel.text = "\(textCount)/10"
    }
    
    func textCountUnder(textCount: Int) {
        editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGray1
        editProfileView.editCompletedButton.backgroundColor = .zoocGray1
        editProfileView.editCompletedButton.isEnabled = false
        editProfileView.profileNameCountLabel.text = "\(textCount)/10"
    }
}
