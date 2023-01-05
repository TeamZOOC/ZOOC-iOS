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
    
    private var alertTitleLabel = UILabel().then {
        $0.backgroundColor = .red
        $0.text = "회원 탈퇴 하시겠습니까?"
    }
    
    private var alertSubTitleLabel = UILabel().then {
        $0.backgroundColor = .yellow
        $0.text = "회원 탈퇴 시 자동으로 탈퇴되고 작성한 글과 댓글이 모두 삭제됩니다"
    }
    
    private var keepEditButton = UIButton().then {
        $0.backgroundColor = .green
    }
    
    private var popToMyViewButton = UIButton().then {
        $0.backgroundColor = .blue
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        view.backgroundColor = .white
    }
    
    private func setLayout(){
        view.addSubviews(alertTitleLabel, alertSubTitleLabel, keepEditButton, popToMyViewButton)
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
        
        alertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.alertTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        keepEditButton.snp.makeConstraints {
            $0.top.equalTo(self.alertSubTitleLabel.snp.bottom).offset(23)
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
