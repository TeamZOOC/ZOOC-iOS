//
//  MyRegisteredPetTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

final class MyRegisteredPetTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    public lazy var petProfileImageView = UIImageView().then {
        $0.makeCornerRadius(ratio: 30)
        $0.contentMode = .scaleAspectFill
    }
    
    public var petProfileNameLabel = UILabel().then {
        $0.textColor = .zoocDarkGreen
        $0.font = .zoocSubhead1
    }
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func cellStyle() {
        self.backgroundColor = .zoocWhite2
        
        petProfileImageView.do {
            $0.makeCornerRadius(ratio: 30)
            $0.contentMode = .scaleAspectFill
        }
        
        petProfileNameLabel.do {
            $0.textColor = .zoocDarkGreen
            $0.font = .zoocSubhead1
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(petProfileImageView, petProfileNameLabel)
    }
    
    private func layout() {
        petProfileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.size.equalTo(60)
        }
        
        petProfileNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.petProfileImageView.snp.trailing).offset(9)
            $0.width.equalTo(196)
            $0.height.equalTo(36)
        }
    }
    
    func dataBind(data: MyPet, index: Int, petData: [MyPet]) {
        petProfileNameLabel.text = data.name
        data.photo == nil ? setDefaultPetProfileImage() : setPetMemberProfileImage(photo: data.photo!)
    }
}

extension MyRegisteredPetTableViewCell {
    func setDefaultPetProfileImage() {
        petProfileImageView.image = Image.defaultProfilePet
    }
    
    func setPetMemberProfileImage(photo: String) {
        petProfileImageView.kfSetImage(url: photo)
    }
}



