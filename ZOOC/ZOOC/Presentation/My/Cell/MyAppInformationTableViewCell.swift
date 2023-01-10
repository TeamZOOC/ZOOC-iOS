//
//  AppInformationTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/03.
//

import UIKit

final class AppInformationTableViewCell: UITableViewCell {
    
    //MARK: - UI Components
    
    private var separatorLine = UIView().then {
        $0.backgroundColor = .zoocLightGray
    }
    
    public var appInformationButton = UIButton()
    
    public var appInformationLabel = UILabel().then {
        $0.textColor = .zoocDarkGray2
        $0.font = .zoocBody2 //zoocBody3
    }
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        contentView.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        contentView.addSubviews(separatorLine, appInformationButton)
        appInformationButton.addSubview(appInformationLabel)
        
        separatorLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(1)
        }
        
        appInformationButton.snp.makeConstraints {
            $0.top.equalTo(self.separatorLine.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(315)
            $0.height.equalTo(40)
        }
        
        appInformationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    public func dataBind(model: AppInformationModel) {
        appInformationLabel.text = model.appInformationName
    }
}


