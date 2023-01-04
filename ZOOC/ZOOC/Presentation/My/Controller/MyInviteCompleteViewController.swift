//
//  MyInvitationCompletedViewController.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

final class MyInviteCompleteViewController : BaseViewController{
    
    //MARK: - Properties
    
    //MARK: - UI Components

    private lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(Image.back, for: .normal)
        button.addTarget(self,
                         action: #selector(backButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private let cardView = UIView().then {
        $0.layer.cornerRadius = 24
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 14
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.backgroundColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "초대 완료!"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocHeadLine
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "가족들을 초대해서 함께 기록해보세요"
        $0.textColor = .zoocGray1
        $0.font = .zoocSubhead1
    }
    
    private let invitationImageView = UIImageView().then {
        $0.image = Image.inviteComplete
        $0.contentMode = .scaleAspectFit
    }
    
    private let invitationButton = UIButton().then {
        $0.setTitle("아카이브 보러가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.backgroundColor = .zoocMainGreen
        $0.layer.cornerRadius = 14
    }
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setLayout(){
        view.backgroundColor = .zoocBackgroundGreen
        view.addSubviews(backButton, cardView)
        
        cardView.addSubviews(titleLabel,
                             descriptionLabel,
                             invitationImageView,
                             invitationButton)
            
        
        //MARK: MakeConstraints
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        cardView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(456)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cardView.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        invitationImageView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        invitationButton.snp.makeConstraints { make in
            make.top.equalTo(self.invitationImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(25)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

