//
//  OnboardingRegisterPetTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

final class OnboardingRegisterPetTableViewCell: UITableViewCell {
    
    //MARK: - UI Components
    
    public var petProfileImageButton = UIButton().then {
        $0.setImage(Image.cameraCircleSmall, for: .normal)
        $0.layer.borderWidth = 5
        $0.layer.borderColor = UIColor.zoocLightGray.cgColor
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    public var petProfileNameTextField = UITextField().then {
        $0.placeholder = "ex) 사랑,토리 (4자 이내)"
        $0.textColor = .zoocDarkGreen
        $0.font = .zoocBody1
        $0.textAlignment = .left
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    public var deletePetProfileButton = UIButton().then {
        $0.setImage(Image.delete, for: .normal)
    }
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
        self.selectionStyle = .none
    }
    
    private func setLayout() {
        contentView.addSubviews(petProfileImageButton, petProfileNameTextField, deletePetProfileButton)
        
        petProfileImageButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.size.equalTo(60)
        }
        
        petProfileNameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalTo(self.petProfileImageButton.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().inset(37)
        }
    }
}
