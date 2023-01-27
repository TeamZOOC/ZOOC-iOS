//
//  DeleteAccountAlertViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class DeleteAccountAlertViewController: BaseViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private var alertView = UIView().then {
        $0.backgroundColor = .white
        $0.makeCornerRadius(ratio: 14)
        $0.alpha = 1
    }
    
    private var contentView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.45
    }
    
    private var alertTitleLabel = UILabel().then {
        $0.backgroundColor = .white
        $0.font = .zoocSubhead2
        $0.text = "회원 탈퇴 하시겠습니까?"
        $0.textColor = .zoocDarkGray1
    }
    
    private var alertSubTitleLabel = UILabel().then {
        $0.font = .zoocBody1
        $0.text = "회원 탈퇴 시 자동으로 가족에서 탈퇴되고 \n  작성한 글과 댓글이 모두 삭제됩니다"
        $0.textColor = .zoocGray1
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textAlignment = .center
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
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
        
        target()
        
        style()
        hierarchy()
        layout()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        keepEditButton.addTarget(self, action: #selector(keepButtonDidTap), for: .touchUpInside)
        popToMyViewButton.addTarget(self, action: #selector(popToMyViewButtonDidTap), for: .touchUpInside)
        
    }
    private func style(){
        view.backgroundColor = .clear
        
        alertView.do {
            $0.backgroundColor = .white
            $0.makeCornerRadius(ratio: 14)
            $0.alpha = 1
        }
        
        contentView.do {
            $0.backgroundColor = .black
            $0.alpha = 0.45
        }
        
        alertTitleLabel.do {
            $0.backgroundColor = .white
            $0.font = .zoocSubhead2
            $0.text = "회원 탈퇴 하시겠습니까?"
            $0.textColor = .zoocDarkGray1
        }
        
        alertSubTitleLabel.do {
            $0.font = .zoocBody1
            $0.text = "회원 탈퇴 시 자동으로 가족에서 탈퇴되고 \n  작성한 글과 댓글이 모두 삭제됩니다"
            $0.textColor = .zoocGray1
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.textAlignment = .center
            let attrString = NSMutableAttributedString(string: $0.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            $0.attributedText = attrString
        }
        
        keepEditButton.do {
            $0.backgroundColor = .zoocMainGreen
            $0.setTitle("계속 할래요", for: .normal)
            $0.setTitleColor(.zoocWhite1, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = .zoocSubhead1
        }
        
        popToMyViewButton.do {
            $0.backgroundColor = .zoocWhite3
            $0.setTitle("탈퇴", for: .normal)
            $0.setTitleColor(.zoocDarkGray2, for: .normal)
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = .zoocSubhead1
        }
    }
    
    private func hierarchy() {
        view.addSubviews(contentView,alertView)
        alertView.addSubviews(alertTitleLabel, alertSubTitleLabel, keepEditButton, popToMyViewButton)
    }
    
    private func layout(){
        alertView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(299)
            $0.height.equalTo(180)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
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
    
    @objc func popToMyViewButtonDidTap() {
        MyAPI.shared.deleteAccount() { result in
            self.dismiss(animated: false)
        }
    }
    
    @objc func keepButtonDidTap() {
        self.dismiss(animated: false)
    }
}

