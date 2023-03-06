//
//  MyRegisterPetTableFooterView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

//MARK: - MyAddButtonTappedDelegate

final class MyRegisterPetTableFooterView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    
    let myPetRegisterViewModel = MyPetRegisterViewModel()
    
    //MARK: - UI Components
    
    private var petRegisterButtonSeparatorLineView = UIView()
    public lazy var addPetProfileButton = UIButton()
    
    //MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        target()
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func target() {
        addPetProfileButton.addTarget(self, action: #selector(addPetProfileButtonDidTap), for: .touchUpInside)
    }
    
    private func style() {
        contentView.backgroundColor = .zoocBackgroundGreen
        
        petRegisterButtonSeparatorLineView.do {
            $0.backgroundColor = .zoocLightGreen
        }
        
        addPetProfileButton.do {
            $0.setTitle("추가", for: .normal)
            $0.setTitleColor(.zoocDarkGreen, for: .normal)
            $0.titleLabel?.font = .zoocBody2
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerBorder(borderWidth: 1, borderColor: .zoocLightGray)
            $0.makeCornerRadius(ratio: 23.5)
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .zoocWhite1
        }
    }
    private func hierarchy() {
        addSubviews(petRegisterButtonSeparatorLineView, addPetProfileButton)
    }
    
    private func layout() {
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
    
    //MARK: - Action Method
    
    @objc func addPetProfileButtonDidTap() {
        myPetRegisterViewModel.addCellClosure?()
    }
}
