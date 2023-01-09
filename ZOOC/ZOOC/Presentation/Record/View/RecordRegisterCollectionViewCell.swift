//
//  RecordRegisterCollectionViewCell.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/09.
//

import UIKit

import SnapKit

final class RecordRegisterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .zoocWhite3
        return view
    }()
    
    private var profilePetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocSubhead1
        label.textColor = .zoocGray2
        return label
    }()
    
    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.check
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
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
        
        borderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        profilePetImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        petNameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.profilePetImageView.snp.trailing).offset(18)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        selectImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(42)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(18)
            $0.height.equalTo(11)
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
        if isSelected{
            contentView.backgroundColor = .zoocWhite2
            profilePetImageView.layer.borderColor = UIColor.zoocMainGreen.cgColor
            profilePetImageView.layer.borderWidth = 2
            petNameLabel.textColor = .zoocMainGreen
            selectImageView.isHidden = false
        } else{
            contentView.backgroundColor = .zoocWhite1
            profilePetImageView.layer.borderColor = nil
            profilePetImageView.layer.borderWidth = 0
            petNameLabel.textColor = .zoocGray2
            selectImageView.isHidden = true
        }
    }
}
