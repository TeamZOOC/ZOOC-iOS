//
//  AppInformationView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/03.
//

import UIKit

import SnapKit
import Then

final class AppInformationView: UIView {
    
    //MARK: - UI Components
    
    private var backButton = UIButton()
    
    private var appInformationLabel = UILabel()
    
    private var currentVersionTitleLabel = UILabel()
    
    private var currentVersionLabel = UILabel()
    
    private var appInformationTableView = UITableView()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
    }
    
    
    private func setLayout() {
        addSubviews(backButton, appInformationLabel, currentVersionTitleLabel,
                    currentVersionLabel, appInformationTableView)
    }
    
    private func register() {
    }
}
