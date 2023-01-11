//
//  MyRegisterPetTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

protocol MyDeleteButtonTappedDelegate {
    func deleteButtonTapped(isSelected: Bool, index: Int)
    
    func canRegister(canRegister: Bool)
}

final class MyRegisterPetTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var delegate: MyDeleteButtonTappedDelegate?
    var index: Int = 0
    var canRegister: Bool = false
    var myPetRegisterdata: [MyPetRegisterModel] = []
    
    
    //MARK: - UI Components
    
    public lazy var petProfileImageButton = UIButton().then {
        $0.setImage(Image.defaultProfile, for: .normal)
        $0.layer.borderWidth = 5
        $0.layer.borderColor = UIColor.zoocWhite1.cgColor
        $0.layer.cornerRadius = 35
        $0.clipsToBounds = true
    }
    
    public var petProfileNameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "ex) 사랑,토리 (4자 이내)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.zoocGray1, NSAttributedString.Key.font: UIFont.zoocBody1])
        $0.addLeftPadding()
        $0.textColor = .zoocDarkGreen
        $0.font = .zoocBody1
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.zoocLightGray.cgColor
        $0.clipsToBounds = true
    }
    
    public lazy var deletePetProfileButton = UIButton().then {
        $0.setImage(Image.delete, for: .normal)
        $0.addTarget(self, action: #selector(deletePetProfileButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        contentView.addSubviews(petProfileImageButton, petProfileNameTextField, deletePetProfileButton)
        
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
        self.myPetRegisterdata = petData
//        print(#function)
//        for i in 0...myPetRegisterdata.count {
//            print(i)
//        }
        
        if(petData.count == 1) {
            deletePetProfileButton.isHidden = true
        } else {
            deletePetProfileButton.isHidden = false
        }
    }
    
    @objc
    private func deletePetProfileButtonDidTap() {
        delegate?.deleteButtonTapped(isSelected: true, index: index)
    }
    
    @objc
    private func textDidChange(_ notification: Notification) {
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
