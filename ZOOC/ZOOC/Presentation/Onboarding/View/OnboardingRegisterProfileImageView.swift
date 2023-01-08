//
//  OnboardingRegisterProfileImageView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterProfileImageView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var registerProfileImageLabel = UILabel().then {
        $0.text = "엄마! \n프로필 사진을 등록할까요?"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
    }
    
    private var registerProfileImageSubLabel = UILabel().then {
        $0.text = "지금 마음에 드는 사진이 없다면 \n나중에 등록할 수 있어요"
        $0.textColor = .zoocGray1
        $0.textAlignment = .left
        $0.font = .zoocBody3
        $0.numberOfLines = 2
    }
    
    public var registerProfileImageButton = UIButton().then {
        $0.setImage(Image.cameraCircleBig, for: .normal)
    }
    
    public var createProfileButton = UIButton().then {
        $0.setTitle("프로필 생성", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 27
        $0.clipsToBounds = true
        $0.backgroundColor = .zoocGradientGreen
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
        addSubviews(backButton, registerProfileImageLabel, registerProfileImageSubLabel, registerProfileImageButton, createProfileButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        registerProfileImageLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
        
        registerProfileImageSubLabel.snp.makeConstraints {
            $0.top.equalTo(self.registerProfileImageLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.registerProfileImageLabel)
        }
        
        registerProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(self.registerProfileImageSubLabel.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(161)
        }
        
        createProfileButton.snp.makeConstraints {
            $0.top.equalTo(self.registerProfileImageButton.snp.bottom).offset(207)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(314)
            $0.height.equalTo(54)
        }
    }
}


