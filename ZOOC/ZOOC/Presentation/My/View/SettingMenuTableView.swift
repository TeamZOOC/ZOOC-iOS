//
//  settingMenuTableView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import Foundation
import UIKit

import SnapKit
import Then

final class SettingMenuTableView: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "SettingMenuTableView"
    
    //MARK: - UI Components
    
    public lazy var friendTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .singleLine
//        $0.delegate = self
//        $0.dataSource = self
    }
    
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
        self.backgroundColor = .green
        addSubview(friendTableView)
    }
    
    
    private func setLayout() {
        friendTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func register() {
    }
}
