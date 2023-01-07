//
//  OnboardingAgreementViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class OnboardingAgreementViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var onboardingAgreementView = OnboardingAgreementView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingAgreementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        onboardingAgreementView.agreeTableView.delegate = self
        onboardingAgreementView.agreeTableView.dataSource = self
        
        onboardingAgreementView.agreeTableView.register(OnboardingAgreementTableViewCell.self, forCellReuseIdentifier: OnboardingAgreementTableViewCell.cellIdentifier)
        onboardingAgreementView.agreeTableView.register(OnboardingAgreementTableHeaderView.self, forHeaderFooterViewReuseIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier)
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate

extension OnboardingAgreementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

//MARK: - UITableViewDataSource

extension OnboardingAgreementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AgreementModel.agreementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingAgreementTableViewCell.cellIdentifier, for: indexPath) as?
                OnboardingAgreementTableViewCell else { return UITableViewCell() }
        cell.dataBind(model: AgreementModel.agreementData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier) as? OnboardingAgreementTableHeaderView else { return UITableViewHeaderFooterView() }
        return cell
    }
}
