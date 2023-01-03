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
    
    private var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var appInformationLabel = UILabel().then {
        $0.font = .zoocHeadLine
        $0.text = "앱 정보"
        $0.textColor = .zoocDarkGray2
    }
    
    private var currentVersionTitleLabel = UILabel().then {
        $0.font = .zoocBody2
        $0.text = "현재 버전"
        $0.textColor = .zoocDarkGray2
    }
    
    private var currentVersionLabel = UILabel().then {
        $0.font = .zoocCaption
        $0.text = "v1.0.0"
        $0.textColor = .zoocDarkGreen
    }
    
    public var appInformationTableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
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
        addSubviews(backButton, appInformationLabel, currentVersionTitleLabel,
                    currentVersionLabel, appInformationTableView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(31)
            $0.size.equalTo(42)
        }
        
        appInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(19)
            $0.leading.equalTo(self.backButton.snp.trailing).offset(100)
        }
        
        currentVersionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(40)
        }
        
        currentVersionLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(85)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        appInformationTableView.snp.makeConstraints {
            $0.top.equalTo(self.currentVersionTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview()
        }
        
        
        
        
    }
}
