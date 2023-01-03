//
//  EditProfileView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class EditProfileView: UIView {
    
    //MARK: - UI Components
    
    private var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var appInformationLabel = UILabel().then {
        $0.font = .zoocHeadLine
        $0.text = "프로필 수정"
        $0.textColor = .zoocDarkGray2
    }
    
    private var editProfileImageView = UIImageView()
    
    private var editProfileCameraImage = UIImageView()
    
    private var editProfileNameTextField = UITextField()
    
    private var profileNameTextFieldUnderLineView = UIView()
    
    private var profileNameCountLabel = UILabel()
    
    private var editCompletedButton = UIButton()
    
    

    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
    }
    
    
    private func setLayout() {
        
    }
}

