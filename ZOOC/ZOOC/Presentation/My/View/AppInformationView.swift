//
//  AppInformationView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

final class AppInformationView: UIView {
    
    //MARK: - UI Components
    
    private var backButton = UIButton()
    
    private var appInformationLabel = UILabel()
    
    private var currentVersionTitleLabel = UILabel()
    
    private var currentVersionLabel = UILabel()
    
    private var appInformationTableView = UITableView()
    
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
        addSubviews(backButton, appInformationLabel, currentVersionTitleLabel,
                    currentVersionLabel, appInformationTableView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(24)
            $0.leading.equalToSuperview().offset(31)
            $0.width.equalTo(8)
            $0.height.equalTo(14)
        }
        
        appInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.centerX.equalToSuperview()
        }
        
        currentVersionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(77)
            $0.leading.equalToSuperview().offset(40)
        }
        
        currentVersionLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(85)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        appInformationTableView.snp.makeConstraints {
            $0.top.equalTo(self.currentVersionTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    private func register() {
    }
}
