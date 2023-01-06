//
//  AnimalCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

final class PetCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    public var petImageView = UIImageView().then {
        $0.image = Image.mockPet2
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
    }
    
    public var petNameLabel = UILabel().then {
        $0.font = .zoocCaption
        $0.text = "복실아들"
        $0.textColor = .zoocDarkGray1
    }

    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setLayout() {
        contentView.addSubviews(petImageView, petNameLabel)
        
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

