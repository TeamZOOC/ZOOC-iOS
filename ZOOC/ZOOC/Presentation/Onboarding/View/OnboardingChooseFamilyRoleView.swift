//
//  OnboardingChooseFamilyRoleView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

final class OnboardingChooseFamilyRoleView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var chooseFamilyLabel = UILabel().then {
        $0.text = "가족에서 \n어떤 역할을 맡고 있나요?"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
    }
    
    private var chooseFamilySubLabel = UILabel().then {
        $0.text = "우리 가족에서 저는"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocBody3
    }
    
    public var chooseFamilyTextField = UITextField().then {
        $0.font = .zoocBody3
        $0.textColor = .zoocGray1
        $0.textAlignment = .left
        $0.placeholder = "ex) 엄마, 아빠, 첫째딸, 둘째딸 (10자 이내)"
    }
    
    public var chooseFamilyTextFeildUnderLineView = UIView().then {
        $0.backgroundColor = .zoocGray1
    }
    
    private var chooseFamilyButton = UIButton().then {
        $0.setTitle("이렇게 불러주세요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
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
        addSubviews(backButton, chooseFamilyLabel, chooseFamilySubLabel, chooseFamilyTextField, chooseFamilyTextFeildUnderLineView, chooseFamilyButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
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
            $0.centerX.equalToSuperview()
            $0.width.equalTo(314)
            $0.height.equalTo(1)
        }
        
        chooseFamilyButton.snp.makeConstraints {
            $0.top.equalTo(self.chooseFamilyTextFeildUnderLineView.snp.bottom).offset(387)
            $0.leading.centerX.equalToSuperview()
            $0.width.equalTo(314)
            $0.height.equalTo(54)
        }
    }
}

