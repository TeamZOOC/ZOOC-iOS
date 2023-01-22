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
    
    private var allSelected : Bool = false
    
    private lazy var onboardingAgreementView = OnboardingAgreementView()
    private var agreementData: [OnboardingAgreementModel] = OnboardingAgreementModel.agreementData
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingAgreementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        target()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        onboardingAgreementView.agreeTableView.delegate = self
        onboardingAgreementView.agreeTableView.dataSource = self
    }
    
    private func target() {
        onboardingAgreementView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingAgreementView.signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpButtonDidTap() {
        pushToWelcomeView()
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
        return agreementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingAgreementTableViewCell.cellIdentifier, for: indexPath) as?
                OnboardingAgreementTableViewCell else { return UITableViewCell() }
        cell.dataBind(model: agreementData[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier) as? OnboardingAgreementTableHeaderView else { return UITableViewHeaderFooterView() }
        cell.dataBind(all: allSelected)
        cell.delegate = self
        return cell
    }
}

//MARK: - ChekedButtonTappedDelegate

extension OnboardingAgreementViewController: ChekedButtonTappedDelegate {
    func cellButtonTapped(isSelected: Bool, index: Int) {
        updateUICellButtonTapped(isSelected: isSelected, index: index)
        onboardingAgreementView.agreeTableView.reloadData()
    }
}

//MARK: - AllChekedButtonTappedDelegate

extension OnboardingAgreementViewController: AllChekedButtonTappedDelegate {
    func allCellButtonTapped(isSelected: Bool) {
        updateUICellAllButtonTapped(isSelected: isSelected)
        onboardingAgreementView.agreeTableView.reloadData()
    }
}

extension OnboardingAgreementViewController {
    private func updateUICellButtonTapped(isSelected: Bool, index: Int) {
        agreementData[index].isSelected = isSelected
        if (agreementData[0].isSelected == true &&
            agreementData[1].isSelected == true &&
            agreementData[3].isSelected == true) {
            onboardingAgreementView.signUpButton.isEnabled = true
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGradientGreen
            allSelected = agreementData[2].isSelected ? true : false
        } else {
            onboardingAgreementView.signUpButton.isEnabled = false
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGray1
            allSelected = false
        }
    }
    
    private func updateUICellAllButtonTapped(isSelected: Bool) {
        let agreementDataIndexList: [Int] = [0, 1, 2, 3]
        if isSelected {
            allSelected = true
            onboardingAgreementView.signUpButton.isEnabled = true
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGradientGreen
            agreementDataIndexList.forEach {
                agreementData[$0].isSelected = true
            }
        } else {
            allSelected = false
            onboardingAgreementView.signUpButton.isEnabled = false
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGray1
            agreementDataIndexList.forEach {
                agreementData[$0].isSelected = false
            }
        }
    }
    
    private func pushToWelcomeView() {
        let welcomeViewController = OnboardingWelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}


