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
    private var agreementData: [AgreementModel] = AgreementModel.agreementData
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingAgreementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        onboardingAgreementView.backButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
        onboardingAgreementView.signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Custom Method
    
    private func register() {
        onboardingAgreementView.agreeTableView.delegate = self
        onboardingAgreementView.agreeTableView.dataSource = self
        
        onboardingAgreementView.agreeTableView.register(OnboardingAgreementTableViewCell.self, forCellReuseIdentifier: OnboardingAgreementTableViewCell.cellIdentifier)
        onboardingAgreementView.agreeTableView.register(OnboardingAgreementTableHeaderView.self, forHeaderFooterViewReuseIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier)
    }
    
    private func pushToWelcomeView() {
        let welcomeViewController = OnboardingWelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func signUpButtonDidTap() {
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

extension OnboardingAgreementViewController: ChekedButtonTappedDelegate {
    func cellButtonTapped(isSelected: Bool, index: Int) {
        agreementData[index].isSelected = isSelected
        
        if (agreementData[0].isSelected == true &&
            agreementData[1].isSelected == true &&
            agreementData[3].isSelected == true) {
            onboardingAgreementView.signUpButton.isEnabled = true
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGradientGreen
            if agreementData[2].isSelected {
                allSelected = true
            }else {
                allSelected = false
            }
        } else {
            onboardingAgreementView.signUpButton.isEnabled = false
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGray1
            allSelected = false
        }
        onboardingAgreementView.agreeTableView.reloadData()
    }
}

extension OnboardingAgreementViewController: AllChekedButtonTappedDelegate {
    func allCellButtonTapped(isSelected: Bool) {
        if isSelected {
            allSelected = true
            onboardingAgreementView.signUpButton.isEnabled = true
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGradientGreen
            agreementData[0].isSelected = true
            agreementData[1].isSelected = true
            agreementData[2].isSelected = true
            agreementData[3].isSelected = true
        } else {
            allSelected = false
            onboardingAgreementView.signUpButton.isEnabled = false
            onboardingAgreementView.signUpButton.backgroundColor = .zoocGray1
            agreementData[0].isSelected = false
            agreementData[1].isSelected = false
            agreementData[2].isSelected = false
            agreementData[3].isSelected = false
        }
        onboardingAgreementView.agreeTableView.reloadData()
    }
}
