//
//  MyRegisterPetViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

import SnapKit
import Then

final class MyRegisterPetViewController: UIViewController{
    
    //MARK: - Properties
    
    private let myRegisterPetView = MyRegisterPetView()
    private var petProfile = MyPetRegisterModel(profileName: "", profileImage:Image.defaultProfile)
    
    private lazy var myPetRegisteredData: [MyPetRegisterModel] = []
    private lazy var myPetRegisterData: [MyPetRegisterModel] = [petProfile]
    
    private var isFull: Bool = false
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = myRegisterPetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    //MARK: - Custom Method
    
    func register() {
        myRegisterPetView.registerPetTableView.delegate = self
        myRegisterPetView.registerPetTableView.dataSource = self
        
        myRegisterPetView.registerPetTableView.register(MyRegisterPetTableViewCell.self, forCellReuseIdentifier: MyRegisterPetTableViewCell.cellIdentifier)
        
        myRegisterPetView.registerPetTableView.register(MyRegisteredPetTableViewCell.self, forCellReuseIdentifier: MyRegisteredPetTableViewCell.cellIdentifier)
        
        myRegisterPetView.registerPetTableView.register(MyRegisterPetTableFooterView.self, forHeaderFooterViewReuseIdentifier: MyRegisterPetTableFooterView.cellIdentifier)
        
        myRegisterPetView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        
        myRegisterPetView.registerPetButton.addTarget(self, action: #selector(registerPetButtonDidTap), for: .touchUpInside)
    }
    
    func registerPet() {
        for i in 0...myPetRegisterData.count-1 {
            print(myPetRegisterData[i].profileName)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func dataSend(myPetRegisteredData: [MyPetRegisterModel]) {
        self.myPetRegisteredData = myPetRegisteredData
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func registerPetButtonDidTap() {
        registerPet()
    }
}

//MARK: - UITableViewDelegate

extension MyRegisterPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 64
        } else {
            return 0
        }
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
            return myPetRegisteredData.count
        case 1:
            return myPetRegisterData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRegisteredPetTableViewCell.cellIdentifier, for: indexPath)
                    as? MyRegisteredPetTableViewCell else { return UITableViewCell() }
            cell.dataBind(model: myPetRegisteredData[indexPath.row], index: indexPath.row, petData: myPetRegisteredData)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRegisterPetTableViewCell.cellIdentifier, for: indexPath)
                    as? MyRegisterPetTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.dataBind(model: myPetRegisterData[indexPath.row], index: indexPath.row, petData: myPetRegisterData)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyRegisterPetTableFooterView.cellIdentifier) as? MyRegisterPetTableFooterView else { return UITableViewHeaderFooterView() }
            cell.delegate = self
            checkIsFull()
            cell.dataBind(isFull: isFull)
            return cell
        default:
            return UIView()
        }
    }
    
}



//MARK: - DeleteButtonTappedDelegate

extension MyRegisterPetViewController: MyDeleteButtonTappedDelegate {
    func deleteButtonTapped(isSelected: Bool, index: Int) {
        if isSelected {
            if myPetRegisterData.count > 1 {
                myPetRegisterData.remove(at: index)
                isFull = false
                if(myPetRegisterData.count + myPetRegisteredData.count == 4) {
                    isFull = true
                }
            }
        }
        myRegisterPetView.registerPetTableView.reloadData()
    }
    
    func canRegister(canRegister: Bool) {
        if canRegister {
            myRegisterPetView.registerPetButton.backgroundColor = .zoocGradientGreen
            myRegisterPetView.registerPetButton.isEnabled = true
        } else {
            myRegisterPetView.registerPetButton.backgroundColor = .zoocGray1
            myRegisterPetView.registerPetButton.isEnabled = false
        }
    }
}

//MARK: - AddButtonTappedDelegate

extension MyRegisterPetViewController: MyAddButtonTappedDelegate {
    func addPetButtonTapped(isSelected: Bool) {
        if isSelected {
            myPetRegisterData.append(petProfile)
        }
        myRegisterPetView.registerPetTableView.reloadData()
    }
}

extension MyRegisterPetViewController {
    private func checkIsFull() {
        if(myPetRegisterData.count + myPetRegisteredData.count >= 4){
            isFull = true
        } else {
            isFull = false
        }
    }
}

