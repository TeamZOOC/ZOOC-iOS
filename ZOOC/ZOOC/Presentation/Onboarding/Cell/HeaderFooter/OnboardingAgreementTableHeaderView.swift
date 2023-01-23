//
//  OnboardingAgreementTableHeaderView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

//MARK: - AllChekedButtonTappedDelegate

protocol AllChekedButtonTappedDelegate : AnyObject {
    func allCellButtonTapped(isSelected: Bool)
}

final class OnboardingAgreementTableHeaderView: UITableViewHeaderFooterView {
    
    private var isSelected: Bool = false
    weak var delegate: AllChekedButtonTappedDelegate?
    
    //MARK: - UI Components
    
    private var allAgreementView = UIView().then {
        $0.makeCornerRadius(ratio: 12)
        $0.makeCornerBorder(borderWidth: 1, borderColor: UIColor.zoocMainGreen)
    }
    
    private var allAgreementLabel = UILabel().then {
        $0.text = "전체 동의"
        $0.textColor = .zoocMainGreen
        $0.font = .zoocSubhead1
        $0.textAlignment = .left
    }
    
    private lazy var allCheckedButton = BaseButton().then {
        $0.setImage(Image.checkBox, for: .normal)
        $0.addTarget(self, action: #selector(checkedButtonDidTap), for: .touchUpInside)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setLayout() {
        contentView.addSubview(allAgreementView)
        allAgreementView.addSubviews(allAgreementLabel, allCheckedButton)
        
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
        
        allCheckedButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
    }
    
    func dataBind(all: Bool){
        updateUI(all: all)
    }
    
    @objc func checkedButtonDidTap() {
        updateAllCheckedButtonUI()
    }
}

extension OnboardingAgreementTableHeaderView {
    private func updateUI(all: Bool) {
        let checkButtonImage = all ? Image.checkBoxFill : Image.checkBox
        allCheckedButton.setImage(checkButtonImage, for: .normal)
    }
    
    private func updateAllCheckedButtonUI() {
        if isSelected {
            isSelected = false
            allCheckedButton.setImage(Image.checkBoxFill, for: .normal)
            delegate?.allCellButtonTapped(isSelected: false)
        } else {
            isSelected = true
            allCheckedButton.setImage(Image.checkBoxFill, for: .normal)
            delegate?.allCellButtonTapped(isSelected: true)
        }
    }
}
