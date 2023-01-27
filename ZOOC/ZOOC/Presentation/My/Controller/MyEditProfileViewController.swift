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
    
    private var isPhoto: Bool = true
    private var myProfileImage: UIImage?
    private var myProfileNickName: String = "기본 닉네임"
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        editProfileView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        editProfileView.editCompletedButton.addTarget(self, action: #selector(editCompleteButtonDidTap), for: .touchUpInside)
        
        editProfileView.editProfileImageButton.addTarget(self, action: #selector(chooseProfileImage) , for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    func dataSend(data: MyUser?) {
        editProfileView.editProfileNameTextField.placeholder = data?.nickName
        data?.photo == nil ? setDefaultProfileImage() : setFamilyMemberProfileImage(photo: (data?.photo!)!)
        guard let name = data?.nickName else { return }
        myProfileNickName = name
    }
    
    //MARK: - Action Method
    
    @objc func chooseProfileImage() {
        let actionSheetController = UIAlertController()
        
        let presentToGalleryButton = UIAlertAction(title: "사진 보관함", style: .default, handler: {action in
            print("ok")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        })
        
        let deleteProfileImageButton = UIAlertAction(title: "사진 삭제", style: .destructive, handler: {action in
            self.editProfileView.editProfileImageButton.setImage(Image.defaultProfilePet, for: .normal)
            self.isPhoto = false
        })
        
        let cancleButton = UIAlertAction(title: "취소", style: .cancel, handler: {action in
            print("cancel")
        })
        
        actionSheetController.addAction(presentToGalleryButton)
        actionSheetController.addAction(deleteProfileImageButton)
        actionSheetController.addAction(cancleButton)
        self.present(actionSheetController, animated: true)
    }
    
    @objc func backButtonDidTap() {
        let myAlertViewController = ZoocAlertViewController()
        myAlertViewController.modalPresentationStyle = .overFullScreen
        present(myAlertViewController, animated: false)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard let text = textField.text else { return }
        switch text.count {
        case 1...9:
            textFieldIsWritten(textCount: text.count)
        case 10...:
            textField.resignFirstResponder()
            let index = text.index(text.startIndex, offsetBy: 10)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
            textFieldIsFull()
        default:
            textFieldIsEmpty(textCount: text.count)
        }
    }
    
    @objc func editCompleteButtonDidTap(){
        guard let text = editProfileView.editProfileNameTextField.text else { return }
        myProfileNickName = text
        MyAPI.shared.patchMyProfile(isPhoto: isPhoto,
                                    nickName: myProfileNickName,
                                    photo: myProfileImage)
        { result in
            guard let result = self.validateResult(result) as? MyUser else { return }
            print(result)
            
            self.popToMyProfileView()
        }
    }
}

extension EditProfileViewController {
    func textFieldIsFull() {
        editProfileView.profileNameCountLabel.text = "10/10"
    }
    
    func textFieldIsWritten(textCount: Int) {
        editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGradientGreen
        editProfileView.editCompletedButton.backgroundColor = .zoocGradientGreen
        editProfileView.editCompletedButton.isEnabled = true
        editProfileView.profileNameCountLabel.text = "\(textCount)/10"
    }
    
    func textFieldIsEmpty(textCount: Int) {
        editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGray1
        editProfileView.editCompletedButton.backgroundColor = .zoocGray1
        editProfileView.editCompletedButton.isEnabled = false
        editProfileView.profileNameCountLabel.text = "\(textCount)/10"
    }
    
    func setDefaultProfileImage() {
        editProfileView.editProfileImageButton.setImage(Image.defaultProfile, for: .normal)
    }
    
    func setFamilyMemberProfileImage(photo: String) {
        editProfileView.editProfileImageButton.kfSetButtonImage(url: photo)
    }
    
    private func popToMyProfileView() {
        guard let beforeVC = self.navigationController?.previousViewController as? MyViewController else { return }
        beforeVC.getMyPageAPI()
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        editProfileView.editProfileImageButton.setImage(image, for: .normal)
        self.myProfileImage = image
    }
}
