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
    
    public lazy var backButton = UIButton()
    private let progressBarView = UIView()
    private let completedProgressBarView = UIView()
    private let participateTitleLabel = UILabel()
    public lazy var familyCodeTextField = UITextField()
    private let participateImage = UIImageView()
    public lazy var nextButton = UIButton()
    
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
        
        progressBarView.do {
            $0.backgroundColor = .zoocLightGreen
            $0.makeCornerRadius(ratio: 2)
        }
        
        completedProgressBarView.do {
            $0.backgroundColor = .zoocMainGreen
            $0.makeCornerRadius(ratio: 2)
        }
        
        participateTitleLabel.do {
            $0.text = "전달받은 가족코드를 \n입력해주세요"
            $0.textColor = .zoocDarkGray1
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
        }
        
        familyCodeTextField.do {
            $0.backgroundColor = .zoocWhite2
            $0.font = .zoocBody2
            $0.textColor = .zoocDarkGreen
            $0.placeholder = "  ex) SEF33210"
            $0.makeCornerRadius(ratio: 8)
        }
        
        participateImage.do {
            $0.image = Image.graphics5
            $0.contentMode = .scaleAspectFit
        }
        
        nextButton.do {
            $0.setTitle("입력하기", for: .normal)
            $0.setTitleColor(.zoocWhite1, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGray1
        }
    }
    
    private func hierarchy() {
        self.addSubviews(
            backButton,
            progressBarView,
            participateTitleLabel,
            familyCodeTextField,
            participateImage,
            nextButton
        )
        progressBarView.addSubview(completedProgressBarView)
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(57)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(4)
        }
        
        completedProgressBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(81)
            $0.bottom.equalToSuperview()
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
            $0.top.equalTo(self.familyCodeTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.nextButton.snp.top).offset(-20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}
