//
//  File.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/02.
//

import UIKit

import SnapKit
import Then

final class MyFamilyInviteViewController : BaseViewController {
    
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
        $0.layer.shadowColor = UIColor.zoocSubGreen.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 14
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.backgroundColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "가족 초대"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocHeadLine
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "가족들을 초대해서 함께 기록해보세요"
        $0.textColor = .zoocGray1
        $0.font = .zoocSubhead1
    }
    
    private let invitationImageView = UIImageView().then {
        $0.image = Image.familyInvite
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var invitationButton = UIButton().then {
        $0.setTitle("아카이브 보러가기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .zoocSubhead1
        $0.backgroundColor = .zoocMainGreen
        $0.layer.cornerRadius = 14
        $0.addTarget(self, action: #selector(invitationButtonDidTap), for: .touchUpInside)
    }
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setLayout(){
        view.backgroundColor = .zoocBackgroundGreen
        view.addSubviews(backButton,
                         cardView)
        
        cardView.addSubviews(titleLabel,
                             descriptionLabel,
                             invitationImageView,
                             invitationButton)
            
        
        //MARK: - MakeConstraints
        
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
        // 마이페이지로 돌아가는 함수
    }
    
    private func pushToMyInvitationCompletedViewController() {
        let myInviteCompleteViewController = MyInviteCompleteViewController()

        self.navigationController?.pushViewController(myInviteCompleteViewController, animated: true)
    }
    
    @objc
    private func invitationButtonDidTap() {
        shareInfo()
    }
    
    private func shareInfo() {
        var objectToShare = [String]()
        
        objectToShare.append("헤헤헿")
        
        /*
         if let text = self.textLabel.text {
             shareItems.append(text)
         }
         */
       
        let activityViewController = UIActivityViewController(activityItems : objectToShare, applicationActivities: nil)
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
        //activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                // 성공했을 때 작업
                self.pushToMyInvitationCompletedViewController()
            }  else  {
               // 실패했을 때 작업
               print("흑흑 슬퍼용")
            }
        }
    }
    
}

