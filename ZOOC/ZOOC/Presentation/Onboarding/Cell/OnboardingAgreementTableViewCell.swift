//
//  OnboardingAgreementTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

//MARK: - ChekedButtonTappedDelegate

protocol ChekedButtonTappedDelegate : AnyObject {
    func cellButtonTapped(isSelected: Bool, index: Int)
}

final class OnboardingAgreementTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: ChekedButtonTappedDelegate?
    var index: Int = 0
    
    //MARK: - UI Components
    
    public var menuLabel = UILabel()
    private lazy var checkedButton = BaseButton()
    
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
    
    public func dataBind(model: OnboardingAgreementModel, index: Int) {
        updateUI(model: model, index: index)
    }
    
    //MARK: - Action Method
    
    @objc func checkButtonDidTap() {
        updatecheckButtonUI()
    }
}

extension OnboardingAgreementTableViewCell {
    private func updateUI(model: OnboardingAgreementModel, index: Int) {
        self.index = index
        menuLabel.text = model.title
        if model.isSelected {
            checkedButton.setImage(Image.checkBoxFill, for: .normal)
        } else {
            checkedButton.setImage(Image.checkBox, for: .normal)
        }
    }
    
    private func updatecheckButtonUI() {
        if checkedButton.currentImage == Image.checkBox {
            delegate?.cellButtonTapped(isSelected: true, index: index)
            checkedButton.setImage(Image.checkBoxFill, for: .normal)
        } else {
            delegate?.cellButtonTapped(isSelected: false, index: index)
            checkedButton.setImage(Image.checkBox, for: .normal)
        }
    }
}

