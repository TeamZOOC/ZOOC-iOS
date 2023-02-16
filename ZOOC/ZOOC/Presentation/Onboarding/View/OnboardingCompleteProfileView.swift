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
    
    public lazy var backButton = UIButton()
    private let progressBarView = UIView()
    private let completedProgressBarView = UIView()
    public let completeProfileLabel = UILabel()
    public let completeProfileSubLabel = UILabel()
    public let completeImage = UIImageView()
    public lazy var getCodeButton = UIButton()
    public lazy var notGetCodeButton = UIButton()
    
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
        
        progressBarView.do {
            $0.backgroundColor = .zoocLightGreen
            $0.makeCornerRadius(ratio: 2)
        }
        
        completedProgressBarView.do {
            $0.backgroundColor = .zoocMainGreen
            $0.makeCornerRadius(ratio: 2)
        }
        
        completeProfileLabel.do {
            $0.text = "멋진 프로필이네요! \n이제 가족과 함께해보세요"
            $0.textColor = .zoocDarkGray1
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.numberOfLines = 2
        }
        
        completeProfileSubLabel.do {
            $0.text = "가족 코드를 받았나요?"
            $0.textColor = .zoocDarkGray1
            $0.textAlignment = .left
            $0.font = .zoocDisplay1
            $0.asColor(targetString: "가족 코드", color: .zoocGradientGreen)
            $0.isHidden = true
        }
        
        completeImage.do {
            $0.image = Image.graphics2
            $0.isHidden = true
            $0.contentMode = .scaleAspectFit
        }
        
        getCodeButton.do {
            $0.setTitle("코드를 받았어요", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGradientGreen
            $0.isHidden = true
        }
        
        notGetCodeButton.do {
            $0.setTitle("아니요", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGradientGreen
            $0.isHidden = true
        }
    }
    
    private func hierarchy() {
        addSubviews(backButton,
                    progressBarView,
                    completeProfileLabel,
                    completeProfileSubLabel,
                    completeImage,
                    getCodeButton,
                    notGetCodeButton)
        
        progressBarView.addSubview(completedProgressBarView)
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(57)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(4)
        }
        
        completedProgressBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(159)
            $0.bottom.equalToSuperview()
        }
        
        completeProfileLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
        
        completeProfileSubLabel.snp.makeConstraints {
            $0.top.equalTo(self.completeProfileLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
        }
        
        completeImage.snp.makeConstraints {
            $0.top.equalTo(self.completeProfileSubLabel.snp.bottom).offset(30)
            $0.bottom.equalTo(self.getCodeButton.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
        }
        
        getCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(self.notGetCodeButton.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(50)
        }
        
        notGetCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(50)
        }
    }
}
