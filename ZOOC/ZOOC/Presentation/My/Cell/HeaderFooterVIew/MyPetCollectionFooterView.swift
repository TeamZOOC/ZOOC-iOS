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
    
    private lazy var registerPetButton = UIButton().then {
        $0.backgroundColor = .zoocLightGray
        $0.setImage(Image.plus, for: .normal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
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
        addSubview(registerPetButton)
        
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



