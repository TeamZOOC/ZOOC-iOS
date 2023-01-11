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
    
    public lazy var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "가족을 초대해보세요"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocDisplay1
        $0.textAlignment = .left
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "함께 추억을 공유하고 싶은 가족들에게 \n초대링크를 보내보세요"
        $0.textColor = .zoocGray1
        $0.textAlignment = .left
        $0.font = .zoocBody3
        $0.numberOfLines = 2
    }

    private let inviteImageView = UIImageView().then {
        $0.image = Image.graphics3
        $0.contentMode = .scaleAspectFit
    }

    public lazy var inviteLatelyButton = UIButton().then {
        $0.setTitle("나중에 초대할게요", for: .normal)
        $0.setTitleColor(.zoocGray1, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.setUnderline()
    }
    
    public lazy var inviteButton = UIButton().then {
        $0.setTitle("초대하기", for: .normal)
        $0.setTitleColor(.zoocWhite1, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.backgroundColor = .zoocGradientGreen
        $0.layer.cornerRadius = 27
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
        addSubviews(backButton, titleLabel, descriptionLabel, inviteImageView, inviteLatelyButton, inviteButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(17)
            $0.size.equalTo(42)
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
            $0.height.equalTo(307)
        }
        
        inviteLatelyButton.snp.makeConstraints {
            $0.top.equalTo(self.inviteImageView.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
        }
        
        inviteButton.snp.makeConstraints {
            $0.top.equalTo(self.inviteLatelyButton.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}
