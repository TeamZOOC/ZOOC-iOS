//
//  SettingMenuTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import Foundation
import UIKit

final class SettingMenuTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "SettingMenuTableViewCell"
    
    //MARK: - UI Components
    
    public var menuButton = UIButton().then {
        $0.setTitleColor(UIColor.zoocDarkGray2, for: .normal)
        $0.titleLabel!.font = UIFont.zoocBody2
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
        contentView.addSubview(menuButton)
    }
    
    private func setLayout() {
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
        }
    }
    
    public func dataBind(model: SettingMenuModel) {
        menuButton.setTitle(model.settingMenuName, for: .normal)
    }
}

