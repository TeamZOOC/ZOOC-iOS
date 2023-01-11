//
//  PetCollectionFooterView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

protocol RegisterPetButtonTappedDelegate: AnyObject {
    func registerPetButtonTapped(isSelected: Bool)
}

final class MyPetCollectionFooterView: UICollectionReusableView {
    
    //MARK: - Properties
    
    weak var delegate: RegisterPetButtonTappedDelegate?
    
    //MARK: - UI Components
    
    private lazy var registerPetButton = UIButton().then {
        $0.backgroundColor = .green //색상 이미지? 고려해야 될 부분
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
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func registerButtonDidTap() {
        delegate?.registerPetButtonTapped(isSelected: true)
    }
}



