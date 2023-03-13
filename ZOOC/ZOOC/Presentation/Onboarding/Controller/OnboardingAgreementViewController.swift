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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 37
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
            )
            self.onboardingAgreementView.agreementTableView.reloadData()
        }
        self.onboardingAgreementViewModel.updateNextButton(
            button:&onboardingAgreementView.signUpButton.isEnabled,
            color: &onboardingAgreementView.signUpButton.backgroundColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingAgreementTableHeaderView.cellIdentifier) as? OnboardingAgreementTableHeaderView else { return UITableViewHeaderFooterView() }
        cell.delegate = self
        if self.onboardingAgreementViewModel.allAgreement { cell.allCheckedButton.setImage(Image.checkBoxFill, for: .normal)
            cell.allAgreementView.layer.borderColor = UIColor.zoocMainGreen.cgColor
        } else {
            cell.allCheckedButton.setImage(Image.checkBox, for: .normal)
            cell.allAgreementView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        cell.onboardingAgreementViewModel.updateAllAgreementClosure = {
            self.onboardingAgreementViewModel.updateAllAgreementState()
            self.onboardingAgreementView.agreementTableView.reloadData()
        }
        self.onboardingAgreementViewModel.updateNextButton(
            button:&onboardingAgreementView.signUpButton.isEnabled,
            color: &onboardingAgreementView.signUpButton.backgroundColor)
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
    private func pushToWelcomeView() {
        let welcomeViewController = OnboardingWelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}
