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
    
    public var progressBarView = UIView().then {
        $0.backgroundColor = .zoocLightGreen
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    public var completedProgressBarView = UIView().then {
        $0.backgroundColor = .zoocMainGreen
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
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
        $0.contentMode = .scaleAspectFit
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
        addSubviews(backButton, progressBarView, completeProfileLabel,  completeProfileSubLabel, completeImage, startButton)
        
        progressBarView.addSubview(completedProgressBarView)
        
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
            $0.leading.trailing.equalToSuperview()
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
            $0.top.equalTo(self.completeProfileSubLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.startButton.snp.top).offset(-20)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(50)
        }
    }
}





