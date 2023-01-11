//
//  OnboardingCompleteProfileView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingCompleteProfileView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var completeProfileLabel = UILabel().then {
        $0.text = "멋진 프로필이네요! \n이제 가족과 함께해보세요"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
    }
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        addSubviews(backButton, completeProfileLabel)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        completeProfileLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
    }
}



