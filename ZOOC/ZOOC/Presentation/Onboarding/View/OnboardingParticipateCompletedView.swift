//
//  OnboardingParticipateCompletedView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingParticipateCompletedView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var completeProfileLabel = UILabel().then {
        $0.text = "합류 완료! \n이제 추억을 쌓을 시간이에요!"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocDisplay1
        $0.numberOfLines = 2
        $0.asColor(targetString: "합류 완료!", color: .zoocMainGreen)
    }
    
    private var completeProfileSubLabel = UILabel().then {
        $0.text = "가족과 기록한 순간들이 \nZOOC 소중한 추억으로 남을게예요"
        $0.textColor = .zoocGray1
        $0.textAlignment = .left
        $0.font = .zoocBody2
        $0.numberOfLines = 2
    }
    
    private var completeImage = UIImageView().then {
        $0.image = Image.graphics4
    }
    
    public var startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 27
        $0.clipsToBounds = true
        $0.backgroundColor = .zoocGradientGreen
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
        addSubviews(backButton, completeProfileLabel, completeProfileSubLabel, completeImage, startButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
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
            $0.top.equalTo(self.completeProfileSubLabel.snp.bottom).offset(52)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(375)
            $0.height.equalTo(364)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(self.completeImage.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(50)
        }
    }
}





