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
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }

    private var appInformationLabel = UILabel().then {
        $0.font = .zoocHeadLine
        $0.text = "프로필 수정"
        $0.textColor = .zoocDarkGray2
    }
    
    public var editProfileImageButton = UIButton().then {
        $0.setImage(Image.symbolLogo, for: .normal)
        $0.layer.cornerRadius = 54.5
    }
    // 여기 이미지 마이프로필에서 가져오면 됨
    // 원형으로 만들기 신경쓰기
    
    private var editProfileCameraIconImageView = UIImageView().then {
        $0.image = Image.camera
        $0.layer.cornerRadius = 17.5
        $0.backgroundColor = .zoocMainGreen
    }
    
    public var editProfileNameTextField = UITextField().then {
        $0.font = .zoocHeadLine
        $0.tintColor = .zoocMainGreen //zoocgragreen
        // 커서 색상
    }
    
    public var profileNameTextFieldUnderLineView = UIView().then {
        $0.backgroundColor = .zoocGray1
    }
        // 색상변경 -> 입력될때마다
    
    
    public var profileNameCountLabel = UILabel().then {
        $0.font = .zoocCaption
        $0.text = "/10"
        $0.textColor = .zoocGray2 //zoocGray3
    }
    
    public var editCompletedButton = UIButton().then {
        $0.backgroundColor = .zoocGray1
        $0.setTitle("완료", for: .normal)
        $0.layer.cornerRadius = 27
        $0.clipsToBounds = true
    }
    
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
        addSubviews(backButton, appInformationLabel, editProfileImageButton, editProfileCameraIconImageView, editProfileNameTextField, profileNameTextFieldUnderLineView, profileNameCountLabel, editCompletedButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        appInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.leading.equalTo(self.backButton.snp.trailing).offset(83)
        }
        
        editProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(self.appInformationLabel.snp.bottom).offset(190)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(109)
        }
        
        editProfileCameraIconImageView.snp.makeConstraints {
            $0.top.equalTo(self.editProfileImageButton).offset(78)
            $0.leading.equalTo(self.editProfileImageButton).offset(78)
            $0.size.equalTo(35)
        }
        
        editProfileNameTextField.snp.makeConstraints {
            $0.top.equalTo(self.editProfileImageButton.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
        }
        
        profileNameTextFieldUnderLineView.snp.makeConstraints {
            $0.top.equalTo(self.editProfileNameTextField.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(205)
            $0.height.equalTo(1)
        }
        
        profileNameCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileNameTextFieldUnderLineView).offset(9)
            $0.leading.equalToSuperview().offset(265)
        }
        
        editCompletedButton.snp.makeConstraints {
            $0.top.equalTo(self.profileNameTextFieldUnderLineView).offset(249)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}

