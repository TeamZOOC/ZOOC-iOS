//
//  OnboardingReInviteFamilyView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

final class OnboardingReInviteFamilyView: UIView {
    
    //MARK: - UI Components
    
    public lazy var backButton = UIButton().then {
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
    
    private let titleLabel = UILabel().then {
        $0.text = "가족을 초대해보세요"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocDisplay1
        $0.textAlignment = .left
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "다시 링크를 복사하고 싶으면 \n하단의 초대링크 복사를 눌러보세요"
        $0.textColor = .zoocGray1
        $0.textAlignment = .left
        $0.font = .zoocBody3
        $0.numberOfLines = 2
    }

    private let inviteImageView = UIImageView().then {
        $0.image = Image.graphics3
        $0.contentMode = .scaleAspectFill
    }

    public lazy var inviteLatelyButton = UIButton().then {
        $0.setTitle("초대링크 복사", for: .normal)
        $0.setTitleColor(.zoocGray1, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.setUnderline()

    }
    
    public lazy var inviteButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.zoocWhite1, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.backgroundColor = .zoocGradientGreen
        $0.makeButtonCornerRadius(ratio: 27)
    }
    
    //MARK: - Life Cycle
    
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
    
    private func setLayout(){
        addSubviews(backButton, progressBarView, titleLabel, descriptionLabel, inviteImageView, inviteLatelyButton, inviteButton)
        
        progressBarView.addSubview(completedProgressBarView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(17)
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
            $0.trailing.equalToSuperview().inset(55)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(30)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.titleLabel)
        }
        
        inviteImageView.snp.makeConstraints {
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(86)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.inviteLatelyButton.snp.top).offset(-30)
        }
        
        inviteLatelyButton.snp.makeConstraints {
            $0.bottom.equalTo(self.inviteButton.snp.top).offset(-15)
            $0.centerX.equalToSuperview()
        }
        
        inviteButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}

