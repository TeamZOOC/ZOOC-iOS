//
//  AppInformationViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class AppInformationViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var appInformationView = AppInformationView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = appInformationView
        appInformationView.backButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        appInformationView.appInformationTableView.delegate = self
        appInformationView.appInformationTableView.dataSource = self
        appInformationView.appInformationTableView.register(AppInformationTableViewCell.self, forCellReuseIdentifier: AppInformationTableViewCell.cellIdentifier)
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate

extension AppInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

//MARK: - UITableViewDataSource

extension AppInformationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppInformationModel.appInformationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppInformationTableViewCell.cellIdentifier, for: indexPath) as?
                AppInformationTableViewCell else { return UITableViewCell() }
        cell.dataBind(model: AppInformationModel.appInformationData[indexPath.row])
        return cell
    }
}
