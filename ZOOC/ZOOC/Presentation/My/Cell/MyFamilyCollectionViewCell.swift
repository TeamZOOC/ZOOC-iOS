//
//  MyFamilyCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

enum MyProfile {
    case family
    case my
    
    var borderWidth: CGFloat {
        switch self {
        case .family:
            return 0
        case .my:
            return 2
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .family:
            return UIColor.clear
        case .my:
            return UIColor.zoocMainGreen
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .family:
            return .zoocDarkGray1
        case .my:
            return .zoocMainGreen
        }
    }
    
    func configProfile(imageView: UIImageView, label: UILabel) {
        imageView.layer.borderWidth = self.borderWidth
        imageView.layer.borderColor = self.borderColor.cgColor
        label.textColor = self.textColor
    }
}

final class MyFamilyCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    public var profileImageView = UIImageView()
    public var profileNameLabel = UILabel()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Custom Method
    
    private func style() {
        profileImageView.do {
            $0.makeCornerRadius(ratio: 24)
            $0.contentMode = .scaleAspectFill
        }
        
        profileNameLabel.do {
            $0.textAlignment = .center
            $0.font = .zoocCaption
            $0.textColor = .zoocDarkGray1
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(profileImageView, profileNameLabel)
    }
    
    private func layout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(48)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    public func dataBind(data: MyUser, myProfileData: MyUser?) {
        profileNameLabel.text = data.nickName
        data.photo == nil ? setDefaultProfileImage() : setFamilyMemberProfileImage(photo: data.photo!)
        let profile: MyProfile = data.nickName == myProfileData?.nickName ? .my : .family
        profile.configProfile(imageView: profileImageView, label: profileNameLabel)
    }
}

extension MyFamilyCollectionViewCell {
    func setDefaultProfileImage() {
        profileImageView.image = Image.defaultProfile
    }
    
    func setFamilyMemberProfileImage(photo: String) {
        profileImageView.kfSetImage(url: photo)
    }
}
