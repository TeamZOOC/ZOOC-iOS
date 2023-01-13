//
//  OnboardingAgreementTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

protocol ChekedButtonTappedDelegate {
    func cellButtonTapped(isSelected: Bool, index: Int)
}


final class OnboardingAgreementTableViewCell: UITableViewCell {
    
    var delegate: ChekedButtonTappedDelegate?
    var index: Int = 0
    
    //MARK: - UI Components
    
    public var menuLabel = UILabel().then {
        $0.textColor = .zoocGray3
        $0.font = .zoocBody1
        $0.textAlignment = .left
    }
    
    private lazy var checkedButton = UIButton().then {
        $0.addTarget(self, action: #selector(agreementIsSelected), for: .touchUpInside)
    }
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
        self.selectionStyle = .none
    }
    
    private func setLayout() {
        contentView.addSubviews(menuLabel, checkedButton)
        
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
        self.index = index
        menuLabel.text = model.title
        if model.isSelected {
            checkedButton.setImage(Image.checkBoxFill, for: .normal)
        } else {
            checkedButton.setImage(Image.checkBox, for: .normal)
        }
    }
    
    //MARK: - Action Method
    
    @objc func agreementIsSelected() {
        if checkedButton.currentImage == Image.checkBox {
            delegate?.cellButtonTapped(isSelected: true, index: index)
            checkedButton.setImage(Image.checkBoxFill, for: .normal)
        } else {
            delegate?.cellButtonTapped(isSelected: false, index: index)
            checkedButton.setImage(Image.checkBox, for: .normal)
        }
    }
}

