//
//  OnboardingLoginView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class OnboardingLoginView: UIView {
    //TODO:
    //2. 카카오톡 로그인 아이콘 집어넣기
    //3. 로티에 사용될 이미지 박기
    
    //MARK: - UI Components
    
    private var loginTitleLabel = UILabel().then {
        $0.text = "가족의 추억을 쭉 \n기록하는 손쉬운 방법"
        $0.textColor = .zoocDarkGray2
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
        
        let attributtedString = NSMutableAttributedString(string: $0.text!)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.zoocGradientGreen, range: ($0.text! as NSString).range(of:"쭉"))
                
        $0.attributedText = attributtedString
    }
    
    private var loginDescribeLabel = UILabel().then {
        $0.text = "ZOOC에서 가족들과 함께 잊지 못할 \n추억을 쭉 쌓아보세요"
        $0.textColor = .zoocGray2
        $0.textAlignment = .left
        $0.font = .zoocBody2
        $0.numberOfLines = 2
    }
    
    public var kakaoLoginButton = UIButton().then {
        $0.setTitle("카카오톡으로 로그인", for: .normal)
        $0.setTitleColor(.zoocDarkGray1, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 27
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(r: 255, g: 231, b: 0)
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
    private func setUI() {}
    
    private func setLayout() {
        addSubviews(loginTitleLabel, loginDescribeLabel, kakaoLoginButton)
        
        loginTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(108)
            $0.leading.equalToSuperview().offset(40)
        }
        
        loginDescribeLabel.snp.makeConstraints {
            $0.top.equalTo(self.loginTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.loginTitleLabel)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(self.loginDescribeLabel.snp.bottom).offset(432)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
    
}
