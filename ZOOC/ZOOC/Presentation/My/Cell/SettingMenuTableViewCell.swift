//
//  SettingMenuTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import Foundation
import UIKit

final class SettingMenuTableViewCell: UITableViewCell {
    
    //MARK: - UI Components
    
    public var menuButton = UIButton().then {
        $0.setTitleColor(.zoocDarkGray2, for: .normal)
        $0.titleLabel!.font = .zoocBody2
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
        contentView.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        contentView.addSubviews(menuButton, separatorLine)
        
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(self.menuButton.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(1)
        }
    }
    
    public func dataBind(model: SettingMenuModel) {
        menuButton.setTitle(model.settingMenuName, for: .normal)
        if(menuButton.titleLabel?.text == "로그아웃"){
            menuButton.setTitleColor(UIColor(r: 235, g: 91, b: 78), for: .normal)
            separatorLine.backgroundColor = UIColor.zoocBackgroundGreen
        }
    }
}

