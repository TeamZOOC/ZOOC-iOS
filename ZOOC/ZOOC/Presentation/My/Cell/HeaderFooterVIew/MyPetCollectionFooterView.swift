//
//  PetCollectionFooterView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

//MARK: - RegisterPetButtonTappedDelegate

protocol RegisterPetButtonTappedDelegate: AnyObject {
    func registerPetButtonTapped(isSelected: Bool)
}

final class MyPetCollectionFooterView: UICollectionReusableView {
    
    //MARK: - Properties
    
    weak var delegate: RegisterPetButtonTappedDelegate?
    
    //MARK: - UI Components
    
    private lazy var registerPetButton = UIButton()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        registerPetButton.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
    }
    
    private func style() {
        registerPetButton.do {
            $0.backgroundColor = .zoocLightGray
            $0.setImage(Image.plus, for: .normal)
            $0.makeCornerRadius(ratio: 20)
        }
    }
    
    private func hierarchy() {
        self.addSubview(registerPetButton)
    }
    
    private func layout() {
        registerPetButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
    
    //MARK: - Action Method
    
    @objc func registerButtonDidTap() {
        delegate?.registerPetButtonTapped(isSelected: true)
    }
}



