//
//  RecordRegisterFourCollectionViewCell.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/10.
//

import UIKit

import SnapKit


final class RecordRegisterFourCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .zoocWhite3
        return view
    }()
    
    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.check
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    private var profilePetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let profileAlphaView: UIView = {
        let view = UIView()
        view.backgroundColor = .zoocMainGreen
        view.alpha = 0.1
        view.isHidden = false
        return view
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocSubhead1
        label.textColor = .zoocGray2
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func setLayout(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubviews(borderView, profilePetImageView, petNameLabel, selectImageView)
        
        profilePetImageView.addSubview(profileAlphaView)
        
        borderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        selectImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(28)
            $0.width.equalTo(18)
            $0.height.equalTo(11)
        }
        
        profilePetImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(49)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        profileAlphaView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        petNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.profilePetImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action Method
    
    func dataBind(model: RecordRegisterModel) {
        profilePetImageView.image = model.profilePetImage
        petNameLabel.text = model.petName
        if model.selectButton {
            selectImageView.isHidden = false
        } else {
            selectImageView.isHidden = true
        }
    }
    
    func updateUI(isSelected: Bool){
        if isSelected {
            contentView.backgroundColor = .zoocWhite2
            profilePetImageView.layer.borderColor = UIColor.zoocMainGreen.cgColor
            profilePetImageView.layer.borderWidth = 2
            profileAlphaView.isHidden = false
            petNameLabel.textColor = .zoocMainGreen
            selectImageView.isHidden = false
        } else {
            contentView.backgroundColor = .zoocWhite1
            profilePetImageView.layer.borderColor = nil
            profilePetImageView.layer.borderWidth = 0
            profileAlphaView.isHidden = true
            petNameLabel.textColor = .zoocGray2
            selectImageView.isHidden = true
        }
    }
}
