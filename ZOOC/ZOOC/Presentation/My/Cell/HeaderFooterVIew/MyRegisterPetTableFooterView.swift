//
//  MyRegisterPetTableFooterView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

//MARK: - MyAddButtonTappedDelegate

protocol MyAddButtonTappedDelegate: AnyObject {
    func addPetButtonTapped(isSelected: Bool)
}

final class MyRegisterPetTableFooterView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    
    weak var delegate: MyAddButtonTappedDelegate?
    
    //MARK: - UI Components
    
    private var petRegisterButtonSeparatorLineView = UIView().then {
        $0.backgroundColor = .zoocLightGreen
    }
    
    private lazy var addPetProfileButton = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(.zoocDarkGreen, for: .normal)
        $0.titleLabel?.font = .zoocBody2
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.zoocLightGray.cgColor
        $0.layer.cornerRadius = 23.5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .zoocWhite1
        $0.addTarget(self, action: #selector(addPetProfileButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        contentView.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        addSubviews(petRegisterButtonSeparatorLineView, addPetProfileButton)
        
        petRegisterButtonSeparatorLineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        addPetProfileButton.snp.makeConstraints {
            $0.top.equalTo(self.petRegisterButtonSeparatorLineView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(43)
        }
    }
    
    public func dataBind(isFull: Bool) {
        updateUI(isFull: isFull)
    }
    
    //MARK: - Action Method
    
    @objc func addPetProfileButtonDidTap() {
        delegate?.addPetButtonTapped(isSelected: true)
    }
}

extension MyRegisterPetTableFooterView {
    func updateUI(isFull: Bool) {
       if isFull{
           petRegisterButtonSeparatorLineView.isHidden = true
           addPetProfileButton.isHidden = true
        } else {
            petRegisterButtonSeparatorLineView.isHidden = false
            addPetProfileButton.isHidden = false
        }
    }
}
