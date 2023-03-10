//
//  OnboardingAgreementTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

//MARK: - ChekedButtonTappedDelegate

protocol CheckedButtonTappedDelegate : AnyObject {
    func cellButtonTapped(index: Int)
}

final class OnboardingAgreementTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    let onboardingAgreementViewModel = OnboardingAgreementViewModel()
    
    weak var delegate: CheckedButtonTappedDelegate?
    var index: Int = 0
    
    //MARK: - UI Components
    
    public var menuLabel = UILabel()
    public lazy var checkedButton = BaseButton()
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        target()
        
        cellStyle()
        hierarchy()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func target() {
        checkedButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    private func cellStyle() {
        self.backgroundColor = .zoocBackgroundGreen
        self.selectionStyle = .none
        
        menuLabel.do {
            $0.textColor = .zoocGray3
            $0.font = .zoocBody1
            $0.textAlignment = .left
        }
    }
    
    private func hierarchy() {
        contentView.addSubviews(menuLabel, checkedButton)
    }
    
    private func layout() {
        menuLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        checkedButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
    }
    
    //MARK: - Action Method
    
    @objc func checkButtonDidTap() {
        updatecheckButtonUI()
    }
}

private extension OnboardingAgreementTableViewCell {
    func updatecheckButtonUI() {
        delegate?.cellButtonTapped(index: index)
        onboardingAgreementViewModel.updateAgreementClosure?()
    }
}

