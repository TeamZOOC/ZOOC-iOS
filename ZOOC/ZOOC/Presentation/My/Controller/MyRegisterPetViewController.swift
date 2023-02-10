//
//  MyRegisterPetViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

import SnapKit
import Then

final class MyRegisterPetViewController: UIViewController {
    
    //MARK: - Properties
    
    private let myRegisterPetView = MyRegisterPetView()
    private let myPetRegisterViewModel: MyPetRegisterViewModel
    private let defaultpetProfile = MyPetRegisterModel(profileName: "", profileImage: Image.defaultProfilePet)
    
    private var myPetMemberData: [MyPet] = []
    
    //MARK: - Life Cycle
    
    init(myPetRegisterViewModel: MyPetRegisterViewModel) {
        self.myPetRegisterViewModel = myPetRegisterViewModel
        myPetRegisterViewModel.petList = [defaultpetProfile]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = myRegisterPetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
        
        register()
        target()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        myRegisterPetView.registerPetTableView.delegate = self
        myRegisterPetView.registerPetTableView.dataSource = self
    }
    
    private func target() {
        myRegisterPetView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        myRegisterPetView.registerPetButton.addTarget(self, action: #selector(registerPetButtonDidTap), for: .touchUpInside)
    }
    
    func dataSend(myPetMemberData: [MyPet]) {
        self.myPetMemberData = myPetMemberData
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func registerPetButtonDidTap() {
        registerPet()
    }
}

//MARK: - UITableViewDelegate

extension MyRegisterPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let height: CGFloat = (section == 1) ? 64 : 0
        return height
    }
}

//MARK: - UITableViewDataSource

extension MyRegisterPetViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return myPetMemberData.count
        case 1:
            return myPetRegisterViewModel.petList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRegisteredPetTableViewCell.cellIdentifier, for: indexPath)
                    as? MyRegisteredPetTableViewCell else { return UITableViewCell() }
            cell.dataBind(data: myPetMemberData[indexPath.row], index: indexPath.row, petData: myPetMemberData)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRegisterPetTableViewCell.cellIdentifier, for: indexPath)
                    as? MyRegisterPetTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            
            [cell.deletePetProfileButton,
             cell.petProfileImageButton,
             cell.petProfileNameTextField].forEach { $0.tag = indexPath.row }
            
            cell.petProfileNameTextField.text = self.myPetRegisterViewModel.petList[indexPath.row].profileName
            cell.petProfileImageButton.setImage(self.myPetRegisterViewModel.petList[indexPath.row].profileImage, for: .normal)
            
            cell.myPetRegisterViewModel.deleteCellClosure = {
                self.myPetRegisterViewModel.deleteCell(index: self.myPetRegisterViewModel.index)
                self.myRegisterPetView.registerPetTableView.reloadData()
            }
            
            self.myPetRegisterViewModel.checkCanRegister(
                button:&self.myRegisterPetView.registerPetButton.isEnabled,
                color:&self.myRegisterPetView.registerPetButton.backgroundColor
            )
            
            self.myPetRegisterViewModel.hideDeleteButton(button: &cell.deletePetProfileButton.isHidden)
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyRegisterPetTableFooterView.cellIdentifier) as? MyRegisterPetTableFooterView else { return UITableViewHeaderFooterView() }
            
            cell.myPetRegisterViewModel.addCellClosure = { [weak self] in
                guard let self = self else { return }
                self.myPetRegisterViewModel.addCell()
                self.myRegisterPetView.registerPetTableView.reloadData()
            }
            self.myPetRegisterViewModel.hideFooterView(button: &cell.addPetProfileButton.isHidden)
            return cell
        default:
            return UIView()
        }
    }
}

//MARK: - MyDeleteButtonTappedDelegate

extension MyRegisterPetViewController: MyDeleteButtonTappedDelegate {
    func petProfileImageButtonDidTap(tag: Int) {
        self.myPetRegisterViewModel.index = tag
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
//    func canRegister(tag: Int, editing: Bool) {
//        self.myPetRegisterViewModel.index = tag
//        for index in 0..<self.myPetRegisterViewModel.petList.count {
//            self.myPetRegisterViewModel.petList[index].editing = (index == tag) ? editing : false
//            print("\(index)번째의 편집유무는 \(editing)")
//        }
//    }
    
    
    func deleteButtonTapped(tag: Int) {
        self.myPetRegisterViewModel.index = tag
    }
    
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: UITableViewCell, tag: Int, image: UIImage) {
        if let _ = myRegisterPetView.registerPetTableView.indexPath(for: cell), let text = textField.text {
            self.myPetRegisterViewModel.petList[tag] = MyPetRegisterModel(profileName: text, profileImage: image)
        }
        self.myPetRegisterViewModel.checkCanRegister(
            button: &self.myRegisterPetView.registerPetButton.isEnabled,
            color: &self.myRegisterPetView.registerPetButton.backgroundColor)
    }
    
}
extension MyRegisterPetViewController {
    func registerPet() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension MyRegisterPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.myPetRegisterViewModel.petList[self.myPetRegisterViewModel.index].profileImage = image
        self.myRegisterPetView.registerPetTableView.reloadData()
    }
}
