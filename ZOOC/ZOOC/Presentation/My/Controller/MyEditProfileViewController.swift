//
//  EditProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then
public var backButton = UIButton()
private var titleLabel = UILabel()

public var profileImageButton = UIButton()
private var cameraIconImageView = UIImageView()
public var nameTextField = UITextField()
public var underLineView = UIView()
public var numberOfNameCharactersLabel = UILabel()
public var completeButton = UIButton()

final class MyEditProfileViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var myProfileData: UserResult?
    private var editMyProfileData = EditProfileRequest()
    
    //MARK: - UIComponents
    
    private lazy var rootView = MyEditProfileView()
    private let galleryAlertController = GalleryAlertController()
    private lazy var imagePickerController = UIImagePickerController()

    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate()
        target()
        style()
    }
    
    //MARK: - Custom Method
    
    private func delegate() {
        galleryAlertController.delegate = self
        imagePickerController.delegate = self
    }
    
    private func target() {
        rootView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        rootView.completeButton.addTarget(self, action: #selector(editCompleteButtonDidTap), for: .touchUpInside)
        
        rootView.profileImageButton.addTarget(self, action: #selector(profileImageButtonDidTap) , for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func style() {
        imagePickerController.do { 
            $0.sourceType = .photoLibrary
        }
    }
    
    func dataBind(data: UserResult?) {
        rootView.nameTextField.text = data?.nickName
        editMyProfileData.nickName = data?.nickName ?? ""
        
        if let photoURL = data?.photo{
            rootView.profileImageButton.kfSetButtonImage(url: photoURL)
        } else {
            rootView.profileImageButton.setImage(Image.defaultProfile, for: .normal)
        }
    }
    
    private func requestPatchUserProfileAPI() {
        MyAPI.shared.patchMyProfile(requset: editMyProfileData) { result in
            //guard let result = self.validateResult(result) as? UserResult else { return }
            self.popToMyProfileView()
        }
    }
    
    //MARK: - Action Method
    
    @objc
    private func profileImageButtonDidTap() {
        present(galleryAlertController,animated: true)
    }
    
    @objc func backButtonDidTap() {
        let myAlertViewController = ZoocAlertViewController()
        myAlertViewController.modalPresentationStyle = .overFullScreen
        present(myAlertViewController, animated: false)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard let text = textField.text else { return }
        var textFieldState: BaseTextFieldState
        switch text.count {
        case 1...9:
            textFieldState = .isWritten
        case 10...:
            textFieldState = .isFull
            let index = text.index(text.startIndex, offsetBy: 10)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
        default:
            textFieldState = .isEmpty
        }
        
        textFieldState.setTextFieldState(
            textField: nil,
            underLineView: rootView.underLineView,
            button: rootView.completeButton
        )
        setTextFieldText(textCount: text.count)
        
    }
    @objc func editCompleteButtonDidTap(){
        guard let nickName = rootView.nameTextField.text else { return }
        self.editMyProfileData.nickName = nickName
        requestPatchUserProfileAPI()
    }
}

extension MyEditProfileViewController {
    func setTextFieldText(textCount: Int) {
        rootView.numberOfNameCharactersLabel.text =  textCount < 10 ? "\(textCount)/10" : "10/10"
    }
    
    func setDefaultProfileImage() {
        rootView.profileImageButton.setImage(Image.defaultProfile, for: .normal)
    }
    
    func setFamilyMemberProfileImage(photo: String) {
        rootView.profileImageButton.kfSetButtonImage(url: photo)
    }
    
    private func popToMyProfileView() {
        guard let beforeVC = self.navigationController?.previousViewController as? MyViewController else { return }
        beforeVC.getMyPageAPI()
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - GalleryAlertControllerDelegate

extension MyEditProfileViewController: GalleryAlertControllerDelegate {
    func galleryButtonDidTap() {
        present(imagePickerController, animated: true)
    }
    
    func deleteButtonDidTap() {
        rootView.profileImageButton.setImage(Image.defaultProfile, for: .normal)
        editMyProfileData.hasPhoto = false
    }
}

//MARK: - UIImagePickerControllerDelegate

extension MyEditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        rootView.profileImageButton.setImage(image, for: .normal)
        rootView.completeButton.backgroundColor = .zoocGradientGreen
        rootView.completeButton.isEnabled = true
        self.editMyProfileData.profileImage = image
        dismiss(animated: true)
    }
}
