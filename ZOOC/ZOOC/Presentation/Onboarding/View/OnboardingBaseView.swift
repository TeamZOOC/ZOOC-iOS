//
//  OnboardingBaseView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/03/13.
//

import UIKit

import SnapKit
import Then

class OnboardingBaseView: UIView {

    //MARK: - UI Components
    
    public lazy var backButton = UIButton()
    public lazy var firstProgressBar = UIView()
    public lazy var secondProgressBar = UIView()
    public lazy var thirdProgressBar = UIView()

    //MARK: - Life Cycles

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        hierarchy()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Custom Method

    private func style() {
        self.backgroundColor = .zoocBackgroundGreen

        backButton.do {
            $0.setImage(Image.back, for: .normal)
        }
        
        firstProgressBar.do {
            $0.backgroundColor = .zoocLightGray
            $0.makeCornerRadius(ratio: 2)
        }
        
        secondProgressBar.do {
            $0.backgroundColor = .zoocLightGray
            $0.makeCornerRadius(ratio: 2)
        }
        
        thirdProgressBar.do {
            $0.backgroundColor = .zoocLightGray
            $0.makeCornerRadius(ratio: 2)
        }
    }
    private func hierarchy() {
        self.addSubviews(
            backButton,
            firstProgressBar,
            secondProgressBar,
            thirdProgressBar
        )
    }

    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        firstProgressBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(self.backButton.snp.bottom).offset(11)
            $0.width.equalTo(106.03)
            $0.height.equalTo(4)
        }
        
        secondProgressBar.snp.makeConstraints {
            $0.leading.equalTo(self.firstProgressBar.snp.trailing).offset(3.96)
            $0.top.equalTo(self.backButton.snp.bottom).offset(11)
            $0.width.equalTo(106.03)
            $0.height.equalTo(4)
            
        }
        thirdProgressBar.snp.makeConstraints {
            $0.leading.equalTo(self.secondProgressBar.snp.trailing).offset(3.96)
            $0.top.equalTo(self.backButton.snp.bottom).offset(11)
            $0.width.equalTo(106.03)
            $0.height.equalTo(4)
            
        }
    }
}

extension OnboardingBaseView {
    func allHidden() {
        firstProgressBar.isHidden = true
        secondProgressBar.isHidden = true
        thirdProgressBar.isHidden = true
    }
    
    func firstStep() {
        firstProgressBar.backgroundColor = .zoocMainGreen
    }
    
    func secondStep() {
        firstProgressBar.backgroundColor = .zoocMainGreen
        secondProgressBar.backgroundColor = .zoocMainGreen
    }
    
    func thirdStep() {
        firstProgressBar.backgroundColor = .zoocMainGreen
        secondProgressBar.backgroundColor = .zoocMainGreen
        thirdProgressBar.backgroundColor = .zoocMainGreen
    }
}

