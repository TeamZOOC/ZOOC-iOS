//
//  File.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import Foundation
import UIKit

final class FamilyCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "FamilyCollectionViewCell"
    
    //MARK: - UI Components
    
    public var familyImageView = UIImageView().then {
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
    }
    
    public var familyNameLabel = UILabel().then {
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
        contentView.addSubviews(familyImageView, familyNameLabel)
    }
    
    private func setLayout() {
        familyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        familyNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.familyImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
    
    public func dataBind(model: MemberModel) {
        familyImageView.image = model.memberProfileImage
        familyNameLabel.text = model.memberProfileName
    }
}
