//
//  AnimalCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import Foundation
import UIKit

final class PetCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "PetCollectionViewCell"
    
    //MARK: - UI Components
    
    public var petImageView = UIImageView().then {
        $0.image = Image.profileMemberImage
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
    }
    
    public var petNameLabel = UILabel().then {
        $0.font = UIFont.zoocCaption
        $0.text = "복실아들"
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
        contentView.addSubviews(petImageView, petNameLabel)
    }
    
    private func setLayout() {
        petImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        petNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.petImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }
    
    public func dataBind(model: MemberModel) {
        petImageView.image = model.memberProfileImage
        petNameLabel.text = model.memberProfileName
    }
}

