//
//  RecordAlertViewController.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/11.
//

import UIKit

import SnapKit
import Then

final class RecordAlertViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .zoocWhite2
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.alpha = 1
        return view
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.45
        return view
    }()
    
    private var alertTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocSubhead2
        label.text = "페이지를 나가시겠어요?"
        label.textColor = .zoocDarkGray1
        return label
    }()
    
    private var alertSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocBody1
        label.text = "지금 떠나면 내용이 저장되지 않아요"
        label.textColor = .zoocGray1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var keepRecordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .zoocMainGreen
        button.setTitle("이어 쓰기", for: .normal)
        button.setTitleColor(.zoocWhite1, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .zoocSubhead1
        button.addTarget(self, action: #selector(keepRecordButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var popToHomeViewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .zoocWhite3
        button.setTitle("나가기", for: .normal)
        button.setTitleColor(.zoocDarkGray2, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .zoocSubhead1
        button.addTarget(self, action: #selector(popToHomeViewButtonDidTap), for: .touchUpInside)
        return button
    }()
    
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
        alertView.addSubviews(alertTitleLabel, alertSubTitleLabel, keepRecordButton, popToHomeViewButton)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(299)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(299)
            $0.height.equalTo(174)
        }
        
        alertTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.centerX.equalToSuperview()
        }
        
        alertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.alertTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        keepRecordButton.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.width.equalTo(179)
            $0.height.equalTo(54)
        }
        
        popToHomeViewButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(54)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func popToHomeViewButtonDidTap() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: false)
    }
    
    @objc
    func keepRecordButtonDidTap() {
        self.dismiss(animated: false, completion: nil)
    }
}
