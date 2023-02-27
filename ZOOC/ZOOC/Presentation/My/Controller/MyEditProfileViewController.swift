//
//  EditProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class MyEditProfileViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var myProfileData: UserResult?
    
    private var isPhoto: Bool = true
    private var profileImage: UIImage?
    private var nickName: String?
    
    //MARK: - UIComponents
    
    private lazy var rootView = MyEditProfileView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        rootView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        rootView.completeButton.addTarget(self, action: #selector(editCompleteButtonDidTap), for: .touchUpInside)
        
        rootView.profileImageButton.addTarget(self, action: #selector(chooseProfileImage) , for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    func dataBind(data: UserResult?) {
        rootView.nameTextField.placeholder = data?.nickName
        
        if let photoURL = data?.photo{
            rootView.profileImageButton.kfSetButtonImage(url: photoURL)
        } else {
            rootView.profileImageButton.setImage(Image.defaultProfile, for: .normal)
        }
        
        self.nickName = data?.nickName
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
            self.rootView.profileImageButton.setImage(Image.defaultProfilePet, for: .normal)
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
        guard let text = rootView.nameTextField.text else { return }
        nickName = text
        MyAPI.shared.patchMyProfile(isPhoto: isPhoto,
                                    nickName: nickName ?? "닉네임이 없습니다.",
                                    photo: profileImage) { result in
            guard let result = self.validateResult(result) as? UserResult else { return }
            print(result)
            
            self.popToMyProfileView()
        }
    }
}

extension MyEditProfileViewController {
    func textFieldIsFull() {
        rootView.numberOfNameCharactersLabel.text = "10/10"
    }
    
    func textFieldIsWritten(textCount: Int) {
        rootView.underLineView.backgroundColor = .zoocGradientGreen
        rootView.completeButton.backgroundColor = .zoocGradientGreen
        rootView.completeButton.isEnabled = true
        rootView.numberOfNameCharactersLabel.text = "\(textCount)/10"
    }
    
    func textFieldIsEmpty(textCount: Int) {
        rootView.underLineView.backgroundColor = .zoocGray1
        rootView.completeButton.backgroundColor = .zoocGray1
        rootView.completeButton.isEnabled = false
        rootView.numberOfNameCharactersLabel.text = "\(textCount)/10"
    }
    
    private func popToMyProfileView() {
        guard let beforeVC = self.navigationController?.previousViewController as? MyViewController else { return }
        beforeVC.getMyPageAPI()
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyEditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        rootView.profileImageButton.setImage(image, for: .normal)
        self.profileImage = image
    }
}
