//
//  AppInformationTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/03.
//

import UIKit

final class AppInformationTableViewCell: UITableViewCell {
    
    //MARK: - UI Components
    
    private var separatorLine = UIView()
    public var appInformationButton = UIButton()
    public var appInformationLabel = UILabel()
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func cellStyle() {
        contentView.backgroundColor = .zoocBackgroundGreen
        
        separatorLine.do {
            $0.backgroundColor = .zoocLightGray
        }
        
        appInformationLabel.do {
            $0.textColor = .zoocDarkGray2
            $0.font = .zoocBody3
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(separatorLine, appInformationButton)
        appInformationButton.addSubview(appInformationLabel)
    }
    
    private func layout() {
        separatorLine.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(1)
        }
        
        appInformationButton.snp.makeConstraints {
            $0.top.equalTo(self.separatorLine.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(40)
        }
        
        appInformationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(10)
        }
    }
    
    public func dataBind(model: MyAppInformationModel) {
        appInformationLabel.text = model.title
    }
}


