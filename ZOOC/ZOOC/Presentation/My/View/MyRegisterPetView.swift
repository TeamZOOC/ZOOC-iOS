//
//  MyRegisterPetCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

import SnapKit
import Then

final class MyRegisterPetView: UIView {

    //MARK: - UI Components
    
    public var backButton = UIButton()
    public var completedProgressBarView = UIView()
    private var registerPetTitleLabel = UILabel()
    private var registerPetSubTitleLabel = UILabel()
    public var registerPetTableView = UITableView(frame: .zero, style: .plain)
    public var registerPetButton =  UIButton()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func register() {
        registerPetTableView.register(
            MyRegisterPetTableViewCell.self,
            forCellReuseIdentifier: MyRegisterPetTableViewCell.cellIdentifier)
        
        registerPetTableView.register(
            MyRegisteredPetTableViewCell.self,
            forCellReuseIdentifier: MyRegisteredPetTableViewCell.cellIdentifier)
        
        registerPetTableView.register(
            MyRegisterPetTableFooterView.self,
            forHeaderFooterViewReuseIdentifier: MyRegisterPetTableFooterView.cellIdentifier)
    }
    
    private func style() {
        self.backgroundColor = .zoocBackgroundGreen
        
        backButton.do {
            $0.setImage(Image.back, for: .normal)
        }
        
        completedProgressBarView.do {
            $0.backgroundColor = .zoocMainGreen
            $0.makeCornerRadius(ratio: 2)
        }
        
        registerPetTitleLabel.do {
            $0.text = "반려동물 등록"
            $0.textColor = .zoocDarkGray2
            $0.textAlignment = .left
            $0.font = .zoocHeadLine
        }
        
        registerPetSubTitleLabel.do {
            $0.text = "최대 4마리까지 등록 가능해요"
            $0.textColor = .zoocGray1
            $0.textAlignment = .left
            $0.font = .zoocBody3
        }
        
        registerPetTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
            $0.backgroundColor = .zoocBackgroundGreen
        }
        
        registerPetButton.do {
            $0.setTitle("등록하기", for: .normal)
            $0.setTitleColor(.zoocWhite1, for: .normal)
            $0.titleLabel?.font = .zoocSubhead1
            $0.titleLabel?.textAlignment = .center
            $0.makeCornerRadius(ratio: 27)
            $0.backgroundColor = .zoocGray1
            $0.isEnabled = false
        }
    }
    
    private func hierarchy() {
        addSubviews(backButton, registerPetTitleLabel, registerPetSubTitleLabel,
                    registerPetTableView, registerPetButton)
    }
    
    private func layout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        registerPetTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        registerPetSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.registerPetTitleLabel.snp.bottom).offset(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        
        registerPetTableView.snp.makeConstraints {
            $0.top.equalTo(self.registerPetSubTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(424)
        }
        
        registerPetButton.snp.makeConstraints {
            $0.top.equalTo(self.registerPetSubTitleLabel.snp.bottom).offset(549)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(54)
        }
    }
}
