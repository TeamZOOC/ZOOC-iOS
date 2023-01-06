//
//  DeleteAccountAlertViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class DeleteAccountAlertViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private var alertView = UIView().then {
        $0.backgroundColor = .zoocBackgroundGreen
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
        $0.alpha = 1
    }
    
    private var contentView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.45
    }
    
    private var alertTitleLabel = UILabel().then {
        $0.backgroundColor = .zoocWhite2
        $0.font = .zoocSubhead2
        $0.text = "회원 탈퇴 하시겠습니까?"
        $0.textColor = .zoocDarkGray1
    }
    
    private var alertSubTitleLabel = UILabel().then {
        $0.font = .zoocBody1
        $0.text = "회원 탈퇴 시 자동으로 가족에서 탈퇴되고 \n 작성한 글과 댓글이 모두 삭제됩니다"
        $0.textColor = .zoocGray1
        $0.textAlignment = .center
    }
    
    private lazy var keepEditButton = UIButton().then {
        $0.backgroundColor = .zoocMainGreen
        $0.setTitle("계속 할래요", for: .normal)
        $0.setTitleColor(.zoocWhite1, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .zoocSubhead1
        $0.addTarget(self, action: #selector(keepButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var popToMyViewButton = UIButton().then {
        $0.backgroundColor = .zoocWhite3
        $0.setTitle("탈퇴", for: .normal)
        $0.setTitleColor(.zoocDarkGray2, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .zoocSubhead1
        $0.addTarget(self, action: #selector(popToMyViewButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        view.backgroundColor = .clear
    }
    
    private func setLayout(){
        view.addSubviews(contentView,alertView)
        alertView.addSubviews(alertTitleLabel, alertSubTitleLabel, keepEditButton, popToMyViewButton)
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(299)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(299)
            $0.height.equalTo(180)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
        
        alertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.alertTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        keepEditButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(126)
            $0.leading.equalToSuperview()
            $0.width.equalTo(179)
            $0.height.equalTo(54)
        }
        
        popToMyViewButton.snp.makeConstraints {
            $0.top.equalTo(self.keepEditButton)
            $0.leading.equalTo(self.keepEditButton.snp.trailing)
            $0.width.equalTo(120)
            $0.height.equalTo(54)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func popToMyViewButtonDidTap() {
        self.dismiss(animated: false)
    }
    
    @objc
    func keepButtonDidTap() {
        self.dismiss(animated: false)
    }
}

