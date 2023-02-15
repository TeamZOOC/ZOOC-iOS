//
//  DeleteAccountView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class MyDeleteAccountSectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    public var deleteAccountButton = UIButton()
    public var deleteAccountButtonUnderLineView = UIView()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func style() {
        deleteAccountButton.do {
            $0.setTitle("회원탈퇴", for: .normal)
            $0.titleLabel?.font = .zoocCaption
            $0.setTitleColor(.zoocDarkGreen, for: .normal)
        }
        
        deleteAccountButtonUnderLineView.do {
            $0.backgroundColor = .zoocDarkGreen
        }
    }
    
    private func hierarchy() {
        addSubviews(deleteAccountButton, deleteAccountButtonUnderLineView)
    }
    
    private func layout() {
        deleteAccountButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(42)
            $0.height.equalTo(14)
        }
        
        deleteAccountButtonUnderLineView.snp.makeConstraints {
            $0.top.equalTo(self.deleteAccountButton.snp.bottom).offset(2)
            $0.leading.equalToSuperview()
            $0.width.equalTo(42)
            $0.height.equalTo(1)
        }
    }
}

