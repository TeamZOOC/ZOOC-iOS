//
//  OnboardingLoginView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import AuthenticationServices
import SnapKit
import Then

final class OnboardingLoginView: UIView {
    
    //MARK: - UI Components
    
    lazy var goHomeButton = UIButton()
    private let loginTitleLabel = UILabel()
    private let loginDescribeLabel = UILabel()
    private let graphicsImageView = UIImageView()
    public lazy var kakaoLoginButton = UIButton()
    public lazy var appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn,
               style: .black)
    
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
        
        goHomeButton.do {
            $0.backgroundColor = .clear
        }
        
        loginTitleLabel.do {
            $0.text = "초코와의 추억을 쭉 \n추억하는 우리만의 방법"
            $0.textColor = .zoocDarkGray2
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
            $0.setAttributeLabel(targetString: ["쭉", "우리만의"], color: .zoocMainGreen, spacing: 2)
        }
        
        loginDescribeLabel.do {
            $0.text = "ZOOC에서 가족들과 함께\n잊지 못할 추억을 쭉 쌓아보세요"
            $0.textColor = .zoocGray2
            $0.textAlignment = .left
            $0.font = .zoocBody2
            $0.numberOfLines = 2
            $0.setLineSpacing(spacing: 2)
        }
        
        graphicsImageView.do {
            $0.image = UIImage(named: "graphics_0")
            $0.contentMode = .scaleAspectFill
        }
        
        appleLoginButton.do {
            $0.makeCornerRadius(ratio: 27)
        }
        
        kakaoLoginButton.do {
            $0.setImage(Image.kakaoLogin, for: .normal)
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = UIColor(r: 255, g: 231, b: 0)
        }
    }
    
    private func hierarchy() {
        self.addSubviews(goHomeButton,
                         loginTitleLabel,
                         loginDescribeLabel,
                         graphicsImageView,
                         appleLoginButton,
                         kakaoLoginButton)
    }
    
    private func layout() {
        goHomeButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(78)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(281)
            $0.height.equalTo(82)
        }
        
        loginDescribeLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginTitleLabel.snp.bottom).offset(18)
            $0.leading.equalTo(self.loginTitleLabel)
            $0.width.equalTo(185)
            $0.height.equalTo(48)
        }
        
        graphicsImageView.snp.makeConstraints {
            $0.top.equalTo(loginDescribeLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(kakaoLoginButton.snp.top).offset(-60)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(graphicsImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}
