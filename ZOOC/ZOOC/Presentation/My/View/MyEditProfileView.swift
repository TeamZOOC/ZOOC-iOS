//
//  EditProfileView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class MyEditProfileView: UIView {
    
    //MARK: - UI Components
    
    public var backButton = UIButton()
    private var titleLabel = UILabel()
    
    public var profileImageButton = UIButton()
    private var cameraIconImageView = UIImageView()
    public var nameTextField = BaseTextField()
    public var underLineView = UIView()
    public var numberOfNameCharactersLabel = UILabel()
    public var completeButton = UIButton()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func style() {
        self.backgroundColor = .zoocBackgroundGreen
        
        backButton.do {
            $0.setImage(Image.back, for: .normal)
        }

        titleLabel.do {
            $0.font = .zoocHeadLine
            $0.text = "프로필 수정"
            $0.textColor = .zoocDarkGray2
        }
        
        profileImageButton.do {
            $0.setImage(Image.logoSymbol, for: .normal)
            $0.makeCornerRadius(ratio: 54.5)
            $0.contentMode = .scaleAspectFill
        }
        
        cameraIconImageView.do {
            $0.image = Image.cameraCircleGreen
            $0.contentMode = .scaleAspectFill
            $0.makeCornerRadius(ratio: 17.5)
        }
        
        nameTextField.do {
            $0.textAlignment = .center
            $0.font = .zoocHeadLine
            $0.tintColor = .zoocGradientGreen
        }
        
        underLineView.do {
            $0.backgroundColor = .zoocGray1
        }
        
        numberOfNameCharactersLabel.do {
            $0.font = .zoocCaption
            $0.text = "/10"
            $0.textColor = .zoocGray3
        }
        
        completeButton.do {
            $0.backgroundColor = .zoocGray1
            $0.setTitle("완료", for: .normal)
            $0.makeCornerRadius(ratio: 27)
        }
    }
    
    private func hierarchy() {
        self.addSubviews(
            backButton,
            titleLabel,
            profileImageButton,
            cameraIconImageView,
            nameTextField,
            underLineView,
            numberOfNameCharactersLabel,
            completeButton)
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.leading.equalTo(self.backButton.snp.trailing).offset(83)
        }
        
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(190)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(109)
        }
        
        cameraIconImageView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(268)
            $0.leading.equalToSuperview().offset(210)
            $0.size.equalTo(30)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(self.profileImageButton.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(self.nameTextField.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(205)
            $0.height.equalTo(1)
        }
        
        numberOfNameCharactersLabel.snp.makeConstraints {
            $0.top.equalTo(self.underLineView).offset(9)
            $0.trailing.equalTo(self.underLineView)
        }
        
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(27)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}

