//
//  OnboardingAgreementView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class OnboardingAgreementView: UIView {

    //MARK: - UI Components
    
    public lazy var backButton = UIButton()
    private let agreeTitleLabel = UILabel()
    public lazy var agreeTableView = UITableView(frame: .zero, style: .grouped)
    public lazy var signUpButton = UIButton()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func register() {
        agreeTableView.register(
            OnboardingAgreementTableViewCell.self,
            forCellReuseIdentifier: OnboardingAgreementTableViewCell.cellIdentifier)
        agreeTableView.register(
            OnboardingAgreementTableHeaderView.self,
            forHeaderFooterViewReuseIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier)
    }
    
    private func style() {
        self.backgroundColor = .zoocBackgroundGreen
        
        backButton.do {
            $0.setImage(Image.back, for: .normal)
        }
        
        agreeTitleLabel.do {
            $0.text = "더 나은 서비스 제공을 위해 \n약관동의가 필요해요"
            $0.textColor = .zoocDarkGray2
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
        }
        
        agreeTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
        }
        
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.zoocWhite1, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGray1
            $0.isEnabled = false
        }
    }
    private func hierarchy() {
        addSubviews(backButton, agreeTitleLabel, agreeTableView, signUpButton)
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(17)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(42)
        }
        
        agreeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(77)
            $0.leading.equalToSuperview().offset(34)
        }
        
        agreeTableView.snp.makeConstraints {
            $0.top.equalTo(self.agreeTitleLabel.snp.bottom).offset(43)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(213)
        }
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}
