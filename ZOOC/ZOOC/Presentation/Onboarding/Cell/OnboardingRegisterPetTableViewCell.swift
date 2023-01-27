//
//  OnboardingRegisterPetTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

//MARK: - DeleteButtonTappedDelegate

protocol DeleteButtonTappedDelegate : AnyObject {
    func deleteButtonTapped(isSelected: Bool, index: Int)
    
    func canRegister(canRegister: Bool)
}

final class OnboardingRegisterPetTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: DeleteButtonTappedDelegate?
    var index: Int = 0
    var canRegister: Bool = false
    
    //MARK: - UI Components
    
    public lazy var petProfileImageButton = UIButton()
    public lazy var petProfileNameTextField = UITextField()
    public lazy var deletePetProfileButton = UIButton()
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        register()
        target()
        
        cellStyle()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func register() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func target() {
        deletePetProfileButton.addTarget(self, action: #selector(deletePetProfileButtonDidTap), for: .touchUpInside)
    }
    
    private func cellStyle() {
        self.selectionStyle = .none
        self.backgroundColor = .zoocBackgroundGreen
        
        petProfileImageButton.do {
            $0.makeCornerBorder(borderWidth: 5, borderColor: UIColor.zoocWhite1)
            $0.makeCornerRadius(ratio: 35)
        }
        
        petProfileNameTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "ex) 사랑,토리 (4자 이내)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.zoocGray1, NSAttributedString.Key.font: UIFont.zoocBody1])
            $0.addLeftPadding(leftInset: 10)
            $0.textColor = .zoocDarkGreen
            $0.font = .zoocBody1
            $0.makeCornerRadius(ratio: 20)
            $0.makeCornerBorder(borderWidth: 1, borderColor: UIColor.zoocLightGray)
        }
        
        deletePetProfileButton.do {
            $0.setImage(Image.delete, for: .normal)
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(petProfileImageButton, petProfileNameTextField, deletePetProfileButton)
    }
    
    private func layout() {
        petProfileImageButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.size.equalTo(70)
        }
        
        petProfileNameTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.petProfileImageButton.snp.trailing).offset(9)
            $0.width.equalTo(196)
            $0.height.equalTo(36)
        }
        
        deletePetProfileButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.petProfileNameTextField.snp.trailing).offset(10)
            $0.size.equalTo(30)
        }
    }
    
    func dataBind(model: OnboardingPetRegisterModel, index: Int, petCount: Int) {
        updateUI(model: model, index: index, petCount: petCount)
    }
    
    //MARK: - Action Method
    
    @objc private func deletePetProfileButtonDidTap() {
        delegate?.deleteButtonTapped(isSelected: true, index: index)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count >= 4 {
                    textField.resignFirstResponder()
                    delegate?.canRegister(canRegister: true)
                }
                else if text.count <= 0 {
                    petProfileNameTextField.layer.borderColor = UIColor.zoocLightGreen.cgColor
                    delegate?.canRegister(canRegister: false)
                }
                else {
                    petProfileNameTextField.layer.borderColor = UIColor.zoocDarkGreen.cgColor
                    delegate?.canRegister(canRegister: true)
                }
            }
        }
    }
}

extension OnboardingRegisterPetTableViewCell {
    private func updateUI(model: OnboardingPetRegisterModel, index: Int, petCount: Int) {
        self.index = index
        petProfileImageButton.setImage(model.profileImage, for: .normal)
        deletePetProfileButton.isHidden = petCount == 1 ? true : false
    }
}
