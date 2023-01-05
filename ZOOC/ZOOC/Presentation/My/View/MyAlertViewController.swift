//
//  AlertView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class MyAlertViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    private var alertView = UIView().then {
        $0.backgroundColor = .zoocBackgroundGreen
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }
    
    private var alertTitleLabel = UILabel().then {
        $0.font = .zoocSubhead2
        $0.text = "회원 탈퇴 하시겠습니까?"
        $0.textColor = .zoocDarkGray1
    }
    
    private var alertSubTitleLabel = UILabel().then {
        $0.font = .zoocBody1
        $0.text = "회원 탈퇴 시 자동으로 가족에서 탈퇴되고 \n 작성한 글과 댓글이 모두 삭제됩니다"
        $0.textColor = .zoocGray1
        $0.textAlignment = .center
        $0.numberOfLines = \2
    }
    
    private var keepEditButton = UIButton().then {
        $0.backgroundColor = .zoocMainGreen
        $0.setTitle("계속 할래요", for: .normal)
        $0.setTitleColor(.zoocWhite1, for: .normal)
        $0.titleLabel?.textAlignment = .center
        
    }
    
    private var popToMyViewButton = UIButton().then {
        $0.backgroundColor = .zoocWhite2 //zoocWhite3
        $0.setTitle("탈퇴", for: .normal)
        $0.setTitleColor(.zoocDarkGray2, for: .normal)
        $0.titleLabel?.textAlignment = .center
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        view.backgroundColor = .zoocGray1
    }
    
    private func setLayout(){
        view.addSubview(alertView)
        alertView.addSubviews(alertTitleLabel, alertSubTitleLabel, keepEditButton, popToMyViewButton)
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(299)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(299)
            $0.height.equalTo(180)
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
    
}
