//
//  AnimalCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

final class MyPetCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    public var petImageView = UIImageView().then {
        $0.image = Image.mockPet2
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }
    
    public var petNameLabel = UILabel().then {
        $0.font = .zoocCaption
        $0.textColor = .zoocDarkGray1
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
        contentView.backgroundColor = .zoocWhite2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.zoocLightGray.cgColor
        contentView.layer.cornerRadius = 21
        contentView.clipsToBounds = true
        
    }
    
    private func setLayout() {
        contentView.addSubviews(petImageView, petNameLabel)
        
        petImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(3)
            $0.size.equalTo(34)
        }
        
        petNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.petImageView.snp.trailing).offset(8)
        }
    }
    
    public func dataBind(data: MyPet) {
        if data.photo == nil {
            petImageView.image = Image.defaultProfilePet
        } else {
            petImageView.kfSetImage(url: data.photo!)
        }
        petNameLabel.text = data.name
    }
}

