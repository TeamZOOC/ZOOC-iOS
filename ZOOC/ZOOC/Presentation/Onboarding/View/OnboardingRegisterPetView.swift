//
//  OnboardingRegisterPetView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterPetView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    public var progressBarView = UIView().then {
        $0.backgroundColor = .zoocLightGreen
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    public var completedProgressBarView = UIView().then {
        $0.backgroundColor = .zoocMainGreen
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    private var registerPetTitleLabel = UILabel().then {
        $0.text = "먼저 서비스 사용을 위해 \n우리 사랑둥이를 입력해주세요"
        $0.textColor = .zoocDarkGray2
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
    }
    
    private var registerPetSubTitleLabel = UILabel().then {
        $0.text = "반려동물은 최대 4마리까지 등록 가능해요"
        $0.textColor = .zoocGray1
        $0.textAlignment = .left
        $0.font = .zoocBody3
    }
    
    public var registerPetTableView = UITableView(frame: .zero, style: .plain).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.backgroundColor = .zoocBackgroundGreen
    }
    
    public var registerPetButton =  UIButton().then {
        $0.setTitle("등록하기", for: .normal)
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
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        addSubviews(backButton, progressBarView, registerPetTitleLabel, registerPetSubTitleLabel, registerPetTableView, registerPetButton)
        
        progressBarView.addSubview(completedProgressBarView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(6)
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
            $0.trailing.equalToSuperview().inset(107)
            $0.bottom.equalToSuperview()
        }
        
        registerPetTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
        
        registerPetSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.registerPetTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.registerPetTitleLabel)
        }
        
        registerPetTableView.snp.makeConstraints {
            $0.top.equalTo(self.registerPetSubTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(424)
        }
        
        registerPetButton.snp.makeConstraints {
            $0.top.equalTo(self.registerPetTableView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
    
    private func register() {
        registerPetTableView.register(
            OnboardingRegisterPetTableViewCell.self,
            forCellReuseIdentifier: OnboardingRegisterPetTableViewCell.cellIdentifier)
        registerPetTableView.register(
            OnboardingRegisterPetTableFooterView.self,
            forHeaderFooterViewReuseIdentifier: OnboardingRegisterPetTableFooterView.cellIdentifier)
    }
}

