//
//  OnboardingRegisterProfileImageView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterProfileImageView: OnboardingBaseView {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    public let registerProfileImageLabel = UILabel()
    private let registerProfileImageSubLabel = UILabel()
    public lazy var registerProfileImageButton = UIButton()
    public lazy var createProfileButton = UIButton()
    
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
        
        firstStep()
        
        registerProfileImageLabel.do {
            $0.textColor = .zoocDarkGray1
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
        }
        
        registerProfileImageSubLabel.do {
            $0.text = "지금 마음에 드는 사진이 없다면 \n나중에 등록할 수 있어요"
            $0.textColor = .zoocGray1
            $0.textAlignment = .left
            $0.font = .zoocBody3
            $0.numberOfLines = 2
        }
        
        registerProfileImageButton.do {
            $0.setImage(Image.cameraCircleBig, for: .normal)
            $0.makeCornerRadius(ratio: 73.5)
            $0.makeCornerBorder(borderWidth: 7, borderColor: .zoocWhite1)
            $0.contentMode = .scaleAspectFill
        }
        
        createProfileButton.do {
            $0.setTitle("프로필 생성", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGradientGreen
        }
    }
    
    private func hierarchy() {
        self.addSubviews(
            registerProfileImageLabel,
            registerProfileImageSubLabel,
            registerProfileImageButton,
            createProfileButton)
    }
    
    private func layout() {
        registerProfileImageLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        
        registerProfileImageSubLabel.snp.makeConstraints {
            $0.top.equalTo(self.registerProfileImageLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.registerProfileImageLabel)
        }
        
        registerProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(self.registerProfileImageSubLabel.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(147)
        }
        
        createProfileButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(314)
            $0.height.equalTo(54)
        }
    }
}
