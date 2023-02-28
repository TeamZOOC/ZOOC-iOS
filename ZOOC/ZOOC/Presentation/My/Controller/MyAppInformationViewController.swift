//
//  AppInformationViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class MyAppInformationViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var appInformationView = MyAppInformationView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = appInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        target()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        appInformationView.appInformationTableView.delegate = self
        appInformationView.appInformationTableView.dataSource = self
    }
    
    private func target() {
        appInformationView.backButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate

extension MyAppInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

//MARK: - UITableViewDataSource

extension MyAppInformationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyAppInformationModel.appInformationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppInformationTableViewCell.cellIdentifier, for: indexPath) as?
                AppInformationTableViewCell else { return UITableViewCell() }
        cell.dataBind(model: MyAppInformationModel.appInformationData[indexPath.row])
        return cell
    }
}
