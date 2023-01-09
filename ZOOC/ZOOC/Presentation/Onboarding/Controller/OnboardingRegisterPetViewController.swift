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
    private var petProfile = OnboardingPetRegisterModel(petProfileName: "", petProfileImage:Image.graphics1)
    
    private lazy var petRegisterData: [OnboardingPetRegisterModel] = [petProfile, petProfile, petProfile, petProfile]
    
    private var isFull: Bool = false
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingRegisterPetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        onboardingRegisterPetView.registerPetTableView.delegate = self
        onboardingRegisterPetView.registerPetTableView.dataSource = self
        
        onboardingRegisterPetView.registerPetTableView.register(OnboardingRegisterPetTableViewCell.self, forCellReuseIdentifier: OnboardingRegisterPetTableViewCell.cellIdentifier)
        onboardingRegisterPetView.registerPetTableView.register(OnboardingRegisterPetTableFooterView.self, forHeaderFooterViewReuseIdentifier: OnboardingRegisterPetTableFooterView.cellIdentifier)
        
        onboardingRegisterPetView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private func checkIsFull() {
        if(petRegisterData.count == 4){
            isFull = true
        } else {
            isFull = false
        }
    }
    
    //MARK: - Action Method

    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OnboardingRegisterPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
}

extension OnboardingRegisterPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petRegisterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingRegisterPetTableViewCell.cellIdentifier, for: indexPath)
                as? OnboardingRegisterPetTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.dataBind(model: petRegisterData[indexPath.row], index: indexPath.row)
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

//MARK: - ChekedButtonTappedDelegate

extension OnboardingRegisterPetViewController: DeleteButtonTappedDelegate {
    func deleteButtonTapped(isSelected: Bool, index: Int) {
        if isSelected {
            if petRegisterData.count > 1 {
                petRegisterData.remove(at: index)
                isFull = false
                if(petRegisterData.count == 4) {
                    isFull = true
                    print("isFull")
                }
            } else {
                print("한마리")
            }
        }
        onboardingRegisterPetView.registerPetTableView.reloadData()
    }
}

extension OnboardingRegisterPetViewController: AddButtonTappedDelegate {
    func addPetButtonTapped(isSelected: Bool) {
        if isSelected {
            petRegisterData.append(petProfile)
        }
        onboardingRegisterPetView.registerPetTableView.reloadData()
    }
}
