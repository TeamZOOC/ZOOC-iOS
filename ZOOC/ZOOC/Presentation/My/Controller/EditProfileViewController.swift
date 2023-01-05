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
        editProfileView.backButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func dataSend(profileName: String, profileImage: UIImage) {
        editProfileView.editProfileImageButton.setImage(profileImage, for: .normal)
        editProfileView.editProfileNameTextField.placeholder = profileName
    }
    
    func register() {
        editProfileView.editProfileNameTextField.delegate = self
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
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
            } else {
                editProfileView.profileNameTextFieldUnderLineView.backgroundColor = .zoocGray1
            }
            return true
        } else {
            editProfileView.profileNameCountLabel.text = "10/10"
            return false
        }
    }
}
