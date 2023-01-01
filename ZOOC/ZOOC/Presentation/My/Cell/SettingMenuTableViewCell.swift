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
    
    public var menuLabel = UILabel().then {
        $0.font = UIFont.zoocBody2
        $0.text = "복실아들"
        $0.textColor = UIColor.zoocDarkGray2
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
        contentView.addSubview(menuLabel)
    }
    
    private func setLayout() {
        menuLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
        }
    }
}

