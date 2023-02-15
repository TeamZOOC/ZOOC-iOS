//
//  settingMenuTableView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import UIKit

import SnapKit
import Then

//MARK: - SettingMenuTableViewCellDelegate

protocol SettingMenuTableViewCellDelegate {
    func selectedSettingMenuTableViewCell(indexPath: IndexPath)
}

final class MySettingSectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var delegate: SettingMenuTableViewCellDelegate?
    private var mySettingData: [MySettingModel] = MySettingModel.settingData
    
    //MARK: - UI Components
    
    public lazy var settingMenuTableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
        
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Custom Method
    
    private func register() {
        settingMenuTableView.delegate = self
        settingMenuTableView.dataSource = self
        
        settingMenuTableView.register(
            MySettingTableViewCell.self,
            forCellReuseIdentifier: MySettingTableViewCell.cellIdentifier)
    }
    
    private func style() {
        self.backgroundColor = .zoocBackgroundGreen
        
        settingMenuTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.separatorStyle = .none
            $0.isScrollEnabled = false
        }
    }
    
    private func hierarchy() {
        addSubview(settingMenuTableView)
    }
    
    private func layout() {
        settingMenuTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate

extension MySettingSectionCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedSettingMenuTableViewCell(indexPath: indexPath)
    }
}

//MARK: - UITableViewDataSource

extension MySettingSectionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySettingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MySettingTableViewCell.cellIdentifier, for: indexPath)
                as? MySettingTableViewCell else { return UITableViewCell() }
        cell.dataBind(data: mySettingData[indexPath.row])
        return cell
    }
}
