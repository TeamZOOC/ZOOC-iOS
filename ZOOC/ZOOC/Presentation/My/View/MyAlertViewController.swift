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
        $0.alpha = 1
    }
    
    private var contentView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.45
    }
    
    private var alertTitleLabel = UILabel().then {
        $0.backgroundColor = .zoocWhite2
        $0.font = .zoocSubhead2
        $0.text = "페이지를 나가시겠어요?"
        $0.textColor = .zoocDarkGray1
    }
    
    private var alertSubTitleLabel = UILabel().then {
        $0.font = .zoocBody1
        $0.text = "지금 떠나면 내용이 저장되지 않아요"
        $0.textColor = .zoocGray1
        $0.textAlignment = .center
    }
    
    private var keepEditButton = UIButton().then {
        $0.backgroundColor = .zoocMainGreen
        $0.setTitle("이어 쓰기", for: .normal)
        $0.setTitleColor(.zoocWhite1, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .zoocSubhead1
        
    }
    
    private lazy var popToMyViewButton = UIButton().then {
        $0.backgroundColor = .zoocWhite2 //zoocWhite3
        $0.setTitle("나가기", for: .normal)
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
    
    private func popToMyView() {
        guard let presentingTBC = self.presentingViewController as? UITabBarController else { return }
        print(presentingTBC)
        guard let presentingNVC = presentingTBC.selectedViewController as? UINavigationController else { return }
        print(presentingNVC)
        guard let presentingVC = presentingNVC.topViewController else { return }
        print(presentingVC)
        presentingVC.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    func popToMyViewButtonDidTap() {
        print(#function)
        popToMyView()
    }
}
