//
//  OnboardingRegisterPetViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class OnboardingRegisterPetViewController: BaseViewController{
    
    //MARK: - Properties
    
    private let onboardingRegisterPetView = OnboardingRegisterPetView()
    private let onboardingPetRegisterViewModel: OnboardingPetRegisterViewModel
    private let defaultpetProfile = OnboardingPetRegisterModel(profileImage: Image.defaultProfilePet, profileName: "")
    
    //MARK: - Life Cycle
    
    init(onboardingPetRegisterViewModel: OnboardingPetRegisterViewModel) {
        self.onboardingPetRegisterViewModel = onboardingPetRegisterViewModel
        onboardingPetRegisterViewModel.petList = [defaultpetProfile]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        var names: [String] = []
        var photos: [UIImage] = []
        for pet in self.onboardingPetRegisterViewModel.petList {
            names.append(pet.profileName)
            photos.append(pet.profileImage)
        }
        
        OnboardingAPI.shared.registerPet(
            petNames: names,
            files: photos
        ) { result in
            guard let result = self.validateResult(result) as? OnboardingRegisterPetResult else { return }
            print("결과는 \(result)")
            self.pushToInviteFamilyViewController()
        }
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
        return onboardingPetRegisterViewModel.petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingRegisterPetTableViewCell.cellIdentifier, for: indexPath)
                as? OnboardingRegisterPetTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        
        [cell.deletePetProfileButton,
         cell.petProfileImageButton,
         cell.petProfileNameTextField].forEach { $0.tag = indexPath.row }
        
        cell.petProfileNameTextField.text = self.onboardingPetRegisterViewModel.petList[indexPath.row].profileName
        cell.petProfileImageButton.setImage(self.onboardingPetRegisterViewModel.petList[indexPath.row].profileImage, for: .normal)
        
        cell.onboardingPetRegisterViewModel.deleteCellClosure = {
            self.onboardingPetRegisterViewModel.deleteCell(index: self.onboardingPetRegisterViewModel.index)
            self.onboardingRegisterPetView.registerPetTableView.reloadData()
        }
        
        self.onboardingPetRegisterViewModel.hideDeleteButton(button: &cell.deletePetProfileButton.isHidden)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingRegisterPetTableFooterView.cellIdentifier) as? OnboardingRegisterPetTableFooterView else { return UITableViewHeaderFooterView() }
        
        cell.onboardingPetRegisterViewModel.addCellClosure = { [weak self] in
            guard let self = self else { return }
            self.onboardingPetRegisterViewModel.addCell()
            self.onboardingRegisterPetView.registerPetTableView.reloadData()
        }
        
        self.onboardingPetRegisterViewModel.hideFooterView(button: &cell.addPetProfileButton.isHidden)
        return cell
    }
}

//MARK: - DeleteButtonTappedDelegate

extension OnboardingRegisterPetViewController: DeleteButtonTappedDelegate {
    func petProfileImageButtonDidTap(tag: Int) {
        self.onboardingPetRegisterViewModel.index = tag
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    func deleteButtonTapped(tag: Int) {
        self.onboardingPetRegisterViewModel.index = tag
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
    
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: UITableViewCell, tag: Int, image: UIImage) {
        if let _ = onboardingRegisterPetView.registerPetTableView.indexPath(for: cell), let text = textField.text {
            self.onboardingPetRegisterViewModel.petList[tag] = OnboardingPetRegisterModel(profileImage: image, profileName: text)
        }
    }
}

extension OnboardingRegisterPetViewController {
    private func pushToInviteFamilyViewController() {
        print("넘어가자!")
        let onboardingInviteFamilyViewController = OnboardingInviteFamilyViewController()
        self.navigationController?.pushViewController(onboardingInviteFamilyViewController, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension OnboardingRegisterPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.onboardingPetRegisterViewModel.petList[self.onboardingPetRegisterViewModel.index].profileImage = image
        self.onboardingRegisterPetView.registerPetTableView.reloadData()
    }
}
