//
//  MyFamilyCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

final class MyFamilyCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    public var familyImageView = UIImageView().then {
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    public var familyNameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .zoocCaption
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configFamilyProfile()
    }
    
    //MARK: - Custom Method
    
    private func setLayout() {
        contentView.addSubviews(familyImageView, familyNameLabel)
        
        familyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        familyNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.familyImageView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public func dataBind(data: MyUser, myProfileData: MyUser?) {
        familyNameLabel.text = data.nickName
        data.photo == nil ? setDefaultProfileImage() : setFamilyMemberProfileImage(photo: data.photo!)
        data.nickName == myProfileData?.nickName ? configMyProfile() : configFamilyProfile()
    }
}

extension MyFamilyCollectionViewCell {
    func configFamilyProfile() {
        familyImageView.layer.borderWidth = 0
        familyImageView.layer.borderColor = UIColor.clear.cgColor
        familyNameLabel.textColor = .zoocDarkGray1
    }
    
    func configMyProfile() {
        familyImageView.layer.borderWidth = 2
        familyImageView.layer.borderColor = UIColor.zoocMainGreen.cgColor
        familyNameLabel.textColor = .zoocMainGreen
    }
    
    func setDefaultProfileImage() {
        familyImageView.image = Image.defaultProfile
    }
    
    func setFamilyMemberProfileImage(photo: String) {
        familyImageView.kfSetImage(url: photo)
    }
}
