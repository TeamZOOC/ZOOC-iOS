//
//  PetCollectionFooterView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/06.
//

import UIKit

import SnapKit
import Then

final class MyPetCollectionFooterView: UICollectionReusableView {
    
    //MARK: - UI Components
    
    private var registerPetButton = UIButton().then {
        $0.backgroundColor = .zoocLightGray //색상 이미지? 고려해야 될 부분
        $0.setImage(Image.plus, for: .normal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
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
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(11)
            $0.size.equalTo(40)
        }
    }
}



