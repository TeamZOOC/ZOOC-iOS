//
//  ProfileView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

//MARK: - EditButtonTappedDelegate

protocol EditButtonTappedDelegate: AnyObject {
    func editButtonTapped()
}

final class MyProfileSectionCollectionViewCell: UICollectionViewCell  {
    
    //MARK: - Properties
    
    weak var delegate: EditButtonTappedDelegate?
    
    //MARK: - UI Components
    
    public var profileImageView = UIImageView()
    public var profileNameLabel = UILabel()
    public var editProfileButton = UIButton()
    
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
        profileImageView.do {
            $0.makeCornerRadius(ratio: 36)
            $0.makeCornerBorder(borderWidth: 2, borderColor: .zoocGray1)
            $0.contentMode = .scaleAspectFill
        }
        
        profileNameLabel.do {
            $0.textColor = .zoocDarkGray2
            $0.font = .zoocHeadLine
        }
        
        editProfileButton.do {
            $0.setTitle("편집", for: .normal)
            $0.titleLabel!.font = .zoocCaption
            $0.setTitleColor(.zoocGray2, for: .normal)
            $0.backgroundColor = .zoocWhite1
            $0.makeCornerRadius(ratio: 12)
            $0.makeCornerBorder(borderWidth: 1, borderColor: .zoocLightGreen)
        }
    }
    
    private func hierarchy() {
        self.addSubviews(
            profileImageView,
            profileNameLabel,
            editProfileButton
        )
    }
    
    private func layout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(38)
            $0.leading.equalToSuperview().offset(38)
            $0.size.equalTo(72)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(62)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(14)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(62)
            $0.trailing.equalToSuperview().inset(36)
            $0.width.equalTo(45)
            $0.height.equalTo(24)
        }
    }
    
    func dataBind(data: MyUser?) {
        profileNameLabel.text = data?.nickName
        data?.photo == nil ? setDefaultProfileImage() : setProfileImage(photo: (data?.photo)!)
    }
}

extension MyProfileSectionCollectionViewCell {
    func setDefaultProfileImage() {
        profileImageView.image = Image.defaultProfile
    }
    
    func setProfileImage(photo: String) {
        profileImageView.kfSetImage(url: photo)
    }
}
