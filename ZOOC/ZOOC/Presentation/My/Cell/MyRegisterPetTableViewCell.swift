//
//  MyRegisterPetTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

//MARK: - MyDeleteButtonTappedDelegate

protocol MyDeleteButtonTappedDelegate: AnyObject {
    func deleteButtonTapped(isSelected: Bool, index: Int)
    
    func canRegister(canRegister: Bool)
    
    func giveRegisterData(myPetRegisterData: [MyPetRegisterModel])
}

final class MyRegisterPetTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: MyDeleteButtonTappedDelegate?
    var index: Int = 0
    var canRegister: Bool = false
    var myPetRegisterData: [MyPetRegisterModel] = []
    
    
    //MARK: - UI Components
    
    public lazy var petProfileImageButton = UIButton()
    public var petProfileNameTextField = UITextField()
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: nil)
        petProfileNameTextField.delegate = self
    }
    
    private func target() {
        deletePetProfileButton.addTarget(self, action: #selector(deletePetProfileButtonDidTap), for: .touchUpInside)
    }
    
    private func cellStyle() {
        self.backgroundColor = .zoocBackgroundGreen
        
        petProfileImageButton.do {
            $0.setImage(Image.defaultProfile, for: .normal)
            $0.makeCornerBorder(borderWidth: 5, borderColor: .zoocWhite1)
            $0.makeCornerRadius(ratio: 35)
            $0.contentMode = .scaleAspectFill
        }
        
        petProfileNameTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "ex) 사랑,토리 (4자 이내)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.zoocGray1, NSAttributedString.Key.font: UIFont.zoocBody1])
            $0.addLeftPadding(leftInset: 10)
            $0.textColor = .zoocDarkGreen
            $0.font = .zoocBody1
            $0.makeCornerBorder(borderWidth: 1, borderColor: .zoocLightGray)
            $0.makeCornerRadius(ratio: 20)
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
    
    func dataBind(model: MyPetRegisterModel, index: Int, petData: [MyPetRegisterModel]) {
        self.index = index
        self.myPetRegisterData = petData
        updateUI(petCnt: petData.count)
    }
    
    func registerPet() {
        if (petProfileNameTextField.text!.count != 0){
            myPetRegisterData[index].profileName = petProfileNameTextField.text!
            myPetRegisterData[index].profileImage = petProfileImageButton.currentImage!
        }
    }
    
    //MARK: - Action Method
    
    @objc private func deletePetProfileButtonDidTap() {
        delegate?.deleteButtonTapped(isSelected: true, index: index)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard let text = textField.text else { return }
        switch text.count {
        case 1...3:
            petProfileNameTextField.layer.borderColor = UIColor.zoocDarkGreen.cgColor
            delegate?.canRegister(canRegister: true)
        case 4...:
            textField.resignFirstResponder()
            delegate?.canRegister(canRegister: true)
        default:
            petProfileNameTextField.layer.borderColor = UIColor.zoocLightGreen.cgColor
            delegate?.canRegister(canRegister: false)
        }
    }
}

extension MyRegisterPetTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        registerPet()
        delegate?.giveRegisterData(myPetRegisterData: myPetRegisterData)
    }
}

extension MyRegisterPetTableViewCell {
    private func updateUI(petCnt: Int) {
        deletePetProfileButton.isHidden = petCnt == 1 ? true : false
    }
}
