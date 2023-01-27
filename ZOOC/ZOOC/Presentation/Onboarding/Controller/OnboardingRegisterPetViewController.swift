//
//  OnboardingRegisterPetViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterPetViewController: UIViewController{
    
    //MARK: - Properties
    
    private let onboardingRegisterPetView = OnboardingRegisterPetView()
    private var petProfile = OnboardingPetRegisterModel(profileImage:Image.defaultProfile)
    
    private lazy var petRegisterData: [OnboardingPetRegisterModel] = [petProfile]
    
    private var isFull: Bool = false
    private var addButtonClicked: Bool = false
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingRegisterPetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        target()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dismissKeyboardWhenTappedAround()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingRegisterPetView.registerPetTableView.delegate = self
        onboardingRegisterPetView.registerPetTableView.dataSource = self
    }
    
    func target() {
        onboardingRegisterPetView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingRegisterPetView.registerPetButton.addTarget(self, action: #selector(registerPetButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method

    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func registerPetButtonDidTap() {
        pushToInviteFamilyViewController()
    }
}

//MARK: - UITableViewDelegate

extension OnboardingRegisterPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
}

//MARK: - UITableViewDataSource

extension OnboardingRegisterPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petRegisterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingRegisterPetTableViewCell.cellIdentifier, for: indexPath)
                as? OnboardingRegisterPetTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.dataBind(model: petRegisterData[indexPath.row], index: indexPath.row, petCount: petRegisterData.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingRegisterPetTableFooterView.cellIdentifier) as? OnboardingRegisterPetTableFooterView else { return UITableViewHeaderFooterView() }
        cell.delegate = self
        checkIsFull()
        cell.dataBind(isFull: isFull)
        return cell
    }
}

//MARK: - DeleteButtonTappedDelegate

extension OnboardingRegisterPetViewController: DeleteButtonTappedDelegate {
    func deleteButtonTapped(isSelected: Bool, index: Int) {
        if isSelected {
            if petRegisterData.count > 1 {
                petRegisterData.remove(at: index)
                isFull = false
                if(petRegisterData.count == 4) {
                    isFull = true
                }
            }
        }
        onboardingRegisterPetView.registerPetTableView.reloadData()
    }
    
    func canRegister(canRegister: Bool) {
        if canRegister {
            onboardingRegisterPetView.registerPetButton.backgroundColor = .zoocGradientGreen
            onboardingRegisterPetView.registerPetButton.isEnabled = true
        } else {
            onboardingRegisterPetView.registerPetButton.backgroundColor = .zoocGray1
            onboardingRegisterPetView.registerPetButton.isEnabled = false
        }
    }
}

//MARK: - AddButtonTappedDelegate

extension OnboardingRegisterPetViewController: AddButtonTappedDelegate {
    func addPetButtonTapped(isSelected: Bool) {
        if isSelected {
            petRegisterData.append(petProfile)
        }
        addButtonClicked = true
        onboardingRegisterPetView.registerPetTableView.reloadData()
    }
}

extension OnboardingRegisterPetViewController {
    private func checkIsFull() {
        isFull = petRegisterData.count == 4 ? true : false
    }
    
    private func pushToInviteFamilyViewController() {
        let onboardingInviteFamilyViewController = OnboardingInviteFamilyViewController()
        self.navigationController?.pushViewController(onboardingInviteFamilyViewController, animated: true)
    }
}
