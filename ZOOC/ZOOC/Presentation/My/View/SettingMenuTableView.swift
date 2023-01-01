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
    
    public lazy var settingMenuTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .singleLine
        $0.isScrollEnabled = false
        $0.delegate = self
        $0.dataSource = self
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
        addSubview(settingMenuTableView)
    }
    
    
    private func setLayout() {
        settingMenuTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func register() {
        settingMenuTableView.register(SettingMenuTableViewCell.self, forCellReuseIdentifier: SettingMenuTableViewCell.identifier)
    }
}

extension SettingMenuTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
}

extension SettingMenuTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenuDummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingMenuTableViewCell.identifier, for: indexPath)
                as? SettingMenuTableViewCell else { return UITableViewCell() }
        cell.dataBind(model: settingMenuDummyData[indexPath.row])
        return cell
    }
}
