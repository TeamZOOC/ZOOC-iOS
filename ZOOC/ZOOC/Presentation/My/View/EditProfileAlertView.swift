//
//  EditProfileAlertView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class EditProfileAlertView: UIView {
    
    //MARK: - UI Components
    
    private let editProfileAlertTitleLabel = UILabel()
    
    private let editProfileAlertSubTitleLabel = UILabel()
    
    private let keepEditButton = UIButton()
    
    private let outButton = UIButton()
    
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
        editProfileAlertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.centerX.equalToSuperview()
        }
        
        editProfileAlertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.editProfileAlertTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
}
    
