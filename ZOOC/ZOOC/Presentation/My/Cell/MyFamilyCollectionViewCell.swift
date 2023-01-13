//
//  MyFamilyCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

final class FamilyCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    public var familyImageView = UIImageView().then {
        $0.layer.cornerRadius = 24
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    public var familyNameLabel = UILabel().then {
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
            $0.centerX.equalToSuperview()
        }
    }
    
    public func dataBind(data: MyUser, myProfileData: MyUser?) {
        
        if data.photo == nil {
            familyImageView.image = Image.defaultProfile
        } else {
            familyImageView.kfSetImage(url: data.photo!)
        }
        familyNameLabel.text = data.nickName
        print("👨‍👩‍👧‍👦👨‍👩‍👧‍👦👨‍👩‍👧‍👦 우리 가족이 셀에 들어왔어요 이름 \(data.nickName)")
        print("👨‍👩‍👧‍👦👨‍👩‍👧‍👦👨‍👩‍👧‍👦 우리 가족이 셀에 들어왔어요 이미지\(data.photo)")
        if (data.nickName == myProfileData?.nickName) {
            familyImageView.layer.borderWidth = 2
            familyImageView.layer.borderColor = UIColor.zoocMainGreen.cgColor
            familyNameLabel.textColor = .zoocMainGreen
        }
    }
}

