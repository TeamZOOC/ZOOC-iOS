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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Custom Method
    
    func dataSend(profileName: String, profileImage: UIImage) {
        editProfileView.editProfileImageButton.setImage(profileImage, for: .normal)
        editProfileView.editProfileNameTextField.placeholder = profileName
    }
}
