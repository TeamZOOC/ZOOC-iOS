//
//  OnboardingChooseFamilyRoleView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

final class OnboardingChooseFamilyRoleView: OnboardingBaseView {
    
    //MARK: - UI Components
    
    //public lazy var backButton = UIButton()
//    public let progressBarView = UIView()
    public let completedProgressBarView = UIView()
    private let chooseFamilyLabel = UILabel()
    private let chooseFamilySubLabel = UILabel()
    public lazy var chooseFamilyTextField = UITextField()
    public let chooseFamilyTextFeildUnderLineView = UIView()
    public lazy var chooseFamilyButton = UIButton()
    
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
        
        chooseFamilyLabel.do {
            $0.text = "가족에서 \n어떤 역할을 맡고 있나요?"
            $0.textColor = .zoocDarkGray1
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
        }
        
        chooseFamilySubLabel.do {
            $0.text = "우리 가족에서 저는"
            $0.textColor = .zoocDarkGray1
            $0.textAlignment = .left
            $0.font = .zoocBody3
        }
        
        chooseFamilyTextField.do {
            $0.font = .zoocBody3
            $0.textColor = .zoocGray1
            $0.textAlignment = .left
            $0.placeholder = "ex) 엄마, 아빠, 첫째딸, 둘째딸 (10자 이내)"
        }
        
        chooseFamilyTextFeildUnderLineView.do {
            $0.backgroundColor = .zoocGray1
        }
        
        chooseFamilyButton.do {
            $0.setTitle("이렇게 불러주세요", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGray1
            $0.isEnabled = false
        }
    }
    
    private func hierarchy() {
        self.addSubviews(
//            backButton,
//            progressBarView,
            chooseFamilyLabel,
            chooseFamilySubLabel,
            chooseFamilyTextField,
            chooseFamilyTextFeildUnderLineView,
            chooseFamilyButton
        )
        //progressBarView.addSubview(completedProgressBarView)
    }
    
    private func layout() {
        
        chooseFamilyLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
        
        chooseFamilySubLabel.snp.makeConstraints {
            $0.top.equalTo(self.chooseFamilyLabel.snp.bottom).offset(40)
            $0.leading.equalTo(self.chooseFamilyLabel)
        }
        
        chooseFamilyTextField.snp.makeConstraints {
            $0.top.equalTo(self.chooseFamilySubLabel.snp.bottom).offset(17)
            $0.leading.equalTo(self.chooseFamilyLabel)
        }
        
        chooseFamilyTextFeildUnderLineView.snp.makeConstraints {
            $0.top.equalTo(self.chooseFamilyTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.chooseFamilyLabel)
            $0.width.equalTo(314)
            $0.height.equalTo(1)
        }
        
        chooseFamilyButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}
