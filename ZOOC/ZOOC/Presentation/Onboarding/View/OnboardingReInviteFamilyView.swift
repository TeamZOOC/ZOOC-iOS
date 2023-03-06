//
//  OnboardingInviteFamilyView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

final class OnboardingInviteFamilyView: UIView {
    
    //MARK: - UI Components
    
    public lazy var backButton = UIButton()
    public let progressBarView = UIView()
    public let completedProgressBarView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let inviteImageView = UIImageView()
    public lazy var inviteLatelyButton = UIButton()
    public lazy var inviteButton = UIButton()
    
    //MARK: - Life Cycle
    
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
        
        titleLabel.do {
            $0.text = "가족을 초대해보세요"
            $0.textColor = .zoocDarkGray1
            $0.font = .zoocDisplay1
            $0.textAlignment = .left
        }

        descriptionLabel.do {
            $0.text = "함께 추억을 공유하고 싶은 가족들에게 \n초대링크를 보내보세요"
            $0.textColor = .zoocGray1
            $0.textAlignment = .left
            $0.font = .zoocBody3
            $0.numberOfLines = 2
        }

        inviteImageView .do {
            $0.image = Image.graphics3
            $0.contentMode = .scaleAspectFill
        }

        inviteLatelyButton.do {
            $0.setTitle("나중에 초대할게요", for: .normal)
            $0.setTitleColor(.zoocGray1, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.setUnderline()
        }
        
        inviteButton.do {
            $0.setTitle("초대하기", for: .normal)
            $0.setTitleColor(.zoocWhite1, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.backgroundColor = .zoocGradientGreen
            $0.makeCornerRadius(ratio: 27)
        }
    }
    
    private func hierarchy() {
        self.addSubviews(
            backButton,
            progressBarView,
            titleLabel,
            descriptionLabel,
            inviteImageView,
            inviteLatelyButton,
            inviteButton
        )
        progressBarView.addSubview(completedProgressBarView)
    }
    
    private func layout() {
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
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.inviteLatelyButton.snp.top).offset(-10)
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
