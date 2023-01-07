//
//  OnboardingAgreementTableHeaderView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

final class OnboardingAgreementTableHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - UI Components
    
    private var allAgreementView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.zoocMainGreen.cgColor
        $0.clipsToBounds = true
    }
    
    private var allAgreementLabel = UILabel().then {
        $0.text = "전체 동의"
        $0.textColor = .zoocMainGreen
        $0.font = .zoocSubhead1
        $0.textAlignment = .left
    }
    
    private var checkedButton = UIButton().then {
        $0.setImage(Image.checkBox, for: .normal)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
    }
    
    private func setLayout() {
        contentView.addSubview(allAgreementView)
        allAgreementView.addSubviews(allAgreementLabel, checkedButton)
        
        allAgreementView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(50)
        }
        
        allAgreementLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
        }
        
        checkedButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
    }
}
