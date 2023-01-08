//
//  OnboardingParticipateView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingParticipateView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var participateTitleLabel = UILabel().then {
        $0.text = "전달받은 가족코드를 \n입력해주세요"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
    }
    
    public var familyCodeTextField = UITextField().then {
        $0.backgroundColor = .zoocWhite2
        $0.font = .zoocBody2
        $0.textColor = .zoocDarkGreen
        $0.placeholder = "ex) SEF33210"
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private var participateImage = UIImageView().then {
        $0.image = Image.graphics5
    }
    
    public var nextButton = UIButton().then {
        $0.setTitle("입력하기", for: .normal)
        $0.setTitleColor(.zoocWhite1, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 27
        $0.clipsToBounds = true
        $0.backgroundColor = .zoocGray1
        $0.isEnabled = false
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
        addSubviews(backButton, participateTitleLabel, familyCodeTextField, participateImage, nextButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(17)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(42)
        }
        
        participateTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
        
        familyCodeTextField.snp.makeConstraints {
            $0.top.equalTo(self.participateTitleLabel.snp.bottom).offset(40)
            $0.leading.equalTo(self.participateTitleLabel)
            $0.width.equalTo(162)
            $0.height.equalTo(41)
        }
        
        participateImage.snp.makeConstraints {
            $0.top.equalTo(self.familyCodeTextField.snp.bottom).offset(82)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(301)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(self.participateImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}

