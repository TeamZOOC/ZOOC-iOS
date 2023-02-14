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
    
    var goHomeButton = UIButton()
    private var loginTitleLabel = UILabel()
    private var loginDescribeLabel = UILabel()
    private let graphicsImageView = UIImageView()
    public var kakaoLoginButton = UIButton()
    public var appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn,
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
            $0.text = "가족의 추억을 쭉 \n기록하는 손쉬운 방법"
            $0.textColor = .zoocDarkGray2
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
            $0.asColor(targetString: "쭉", color: .zoocGradientGreen)
        }
        
        loginDescribeLabel.do {
            $0.text = "ZOOC에서 가족들과 함께 잊지 못할 \n추억을 쭉 쌓아보세요"
            $0.textColor = .zoocGray2
            $0.textAlignment = .left
            $0.font = .zoocBody2
            $0.numberOfLines = 2
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
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(108)
            $0.leading.equalToSuperview().offset(40)
        }
        
        loginDescribeLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.loginTitleLabel)
        }
        
        graphicsImageView.snp.makeConstraints {
            $0.top.equalTo(loginDescribeLabel.snp.bottom).offset(60)
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
