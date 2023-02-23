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
    private let onboardingAgreementViewModel: OnboardingAgreementViewModel
    
    init(onboardingAgreementViewModel: OnboardingAgreementViewModel) {
        self.onboardingAgreementViewModel = onboardingAgreementViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        onboardingAgreementView.agreementTableView.delegate = self
        onboardingAgreementView.agreementTableView.dataSource = self
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
        return onboardingAgreementViewModel.agreementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingAgreementTableViewCell.cellIdentifier, for: indexPath) as?
                OnboardingAgreementTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.checkedButton.tag = indexPath.row
        cell.menuLabel.text = self.onboardingAgreementViewModel.agreementList[indexPath.row].title
        
        if self.onboardingAgreementViewModel.agreementList[indexPath.row].isSelected {
            cell.checkedButton.setImage(Image.checkBoxFill, for: .normal)
        } else {
            cell.checkedButton.setImage(Image.checkBox, for: .normal)
        }
        
        cell.onboardingAgreementViewModel.updateAgreementClosure = {
            self.onboardingAgreementViewModel.updateAgreementState(
                index: indexPath.row
                //button: &cell.checkedButton
            )
            self.onboardingAgreementView.agreementTableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier) as? OnboardingAgreementTableHeaderView else { return UITableViewHeaderFooterView() }
        cell.delegate = self
        if self.onboardingAgreementViewModel.allAgreement { cell.allCheckedButton.setImage(Image.checkBoxFill, for: .normal)
        } else {
            cell.allCheckedButton.setImage(Image.checkBox, for: .normal)
        }
        
        cell.onboardingAgreementViewModel.updateAllAgreementClosure = {
            self.onboardingAgreementViewModel.updateAllAgreementState()
            self.onboardingAgreementViewModel.updateAllAgreementButtonTapped()
            self.onboardingAgreementView.agreementTableView.reloadData()
        }
        return cell
    }
}

//MARK: - ChekedButtonTappedDelegate

extension OnboardingAgreementViewController: CheckedButtonTappedDelegate {
    func cellButtonTapped(index: Int) {
        onboardingAgreementViewModel.index = index
        onboardingAgreementView.agreementTableView.reloadData()
    }
}

//MARK: - AllChekedButtonTappedDelegate

extension OnboardingAgreementViewController: AllChekedButtonTappedDelegate {
    func allCellButtonTapped() {
        onboardingAgreementView.agreementTableView.reloadData()
    }
}

extension OnboardingAgreementViewController {
    //    private func updateUICellButtonTapped(isSelected: Bool, index: Int) {
    //        agreementData[index].isSelected = isSelected
    //        if (agreementData[0].isSelected == true &&
    //            agreementData[1].isSelected == true &&
    //            agreementData[3].isSelected == true) {
    //            onboardingAgreementView.signUpButton.isEnabled = true
    //            onboardingAgreementView.signUpButton.backgroundColor = .zoocGradientGreen
    //            allSelected = agreementData[2].isSelected ? true : false
    //        } else {
    //            onboardingAgreementView.signUpButton.isEnabled = false
    //            onboardingAgreementView.signUpButton.backgroundColor = .zoocGray1
    //            allSelected = false
    //        }
    //    }
    //
    //    private func updateUICellAllButtonTapped(isSelected: Bool) {
    //        let agreementDataIndexList: [Int] = [0, 1, 2, 3]
    //        if isSelected {
    //            allSelected = true
    //            onboardingAgreementView.signUpButton.isEnabled = true
    //            onboardingAgreementView.signUpButton.backgroundColor = .zoocGradientGreen
    //            agreementDataIndexList.forEach {
    //                agreementData[$0].isSelected = true
    //            }
    //        } else {
    //            allSelected = false
    //            onboardingAgreementView.signUpButton.isEnabled = false
    //            onboardingAgreementView.signUpButton.backgroundColor = .zoocGray1
    //            agreementDataIndexList.forEach {
    //                agreementData[$0].isSelected = false
    //            }
    //        }
    //    }
    
    private func pushToWelcomeView() {
        let welcomeViewController = OnboardingWelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}
