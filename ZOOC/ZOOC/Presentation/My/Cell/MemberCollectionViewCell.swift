//
//  File.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import Foundation
import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "MemberCollectionViewCell"
    
    //MARK: - UI Components
    
    public var memberImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
    }
    
    public var memberNameLabel = UILabel().then {
        $0.font = UIFont.zoocCaption
        $0.textColor = UIColor.zoocDarkGray1
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
        contentView.addSubviews(memberImageView, memberNameLabel)
    }
    
    private func setLayout() {
        memberImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.memberImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
}
