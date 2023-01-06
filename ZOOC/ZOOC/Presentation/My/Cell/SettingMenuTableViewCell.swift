//
//  SettingMenuTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import UIKit

final class SettingMenuTableViewCell: UITableViewCell {
    
    //MARK: - UI Components
    
    public var menuLabel = UILabel().then {
        $0.textColor = .zoocDarkGray2
        $0.font = .zoocBody2
    }
    
    private var separatorLine = UIView().then {
        $0.backgroundColor = .zoocLightGray
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
        self.backgroundColor = .zoocBackgroundGreen
        self.selectionStyle = .none
    }
    
    private func setLayout() {
        contentView.addSubviews(menuLabel, separatorLine)
        
        menuLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(10)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(self.menuLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(1)
        }
    }
    
    public func dataBind(model: SettingMenuModel) {
        menuLabel.text = model.settingMenuName
        if model.isLogout {
            menuLabel.textColor = UIColor(r: 235, g: 91, b: 78)
            separatorLine.isHidden = true
        }
    }
}

