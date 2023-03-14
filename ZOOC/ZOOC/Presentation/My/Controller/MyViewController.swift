//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then
import Moya

final class MyViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var myFamilyMemberData: [UserResult] = []
    private var myPetMemberData: [PetResult] = []
    private var myProfileData: UserResult?
    
    //MARK: - UI Components
    
    private lazy var myView = MyView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestMyPageAPI()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        myView.myCollectionView.delegate = self
        myView.myCollectionView.dataSource = self
    }
    
    func dataSend(myprofileData: UserResult?) {
        guard let nickNameData = myProfileData?.nickName else { return }
        guard let photoData = myProfileData?.photo else { return }
        myView.myCollectionView.reloadData()
    }
    
    func requestMyPageAPI(){
        MyAPI.shared.getMyPageData() { result in
            
            guard let result = self.validateResult(result) as? MyResult else { return }
            
            self.myProfileData = result.user
            self.myFamilyMemberData = result.familyMember
            self.myPetMemberData = result.pet
            
            self.myView.myCollectionView.reloadData()
        }
    }
    
    private func logout() {
        User.shared.clearData()
        changeRootViewController(OnboardingLoginViewController())
    }
    
    //MARK: - Action Method
    
    @objc private func editProfileButtonDidTap() {
        pushToEditProfileView()
    }
    
    @objc private func appInformationButtonDidTap() {
        pushToAppInformationView()
    }
    
    @objc func deleteAccountButtonDidTap() {
        let deleteAccountAlertViewController = DeleteAccountAlertViewController()
        deleteAccountAlertViewController.modalPresentationStyle = .overFullScreen
        present(deleteAccountAlertViewController, animated: false)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 140)
        case 1:
            return CGSize(width: 315, height: 155)
        case 2:
            return CGSize(width: 315, height: 127)
        case 3:
            return CGSize(width: 315, height: 346)
        case 4:
            return CGSize(width: 42, height: 17)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 30)
        case 2:
            return UIEdgeInsets(top: 0, left: 30, bottom: 22, right: 30)
        case 3:
            return UIEdgeInsets(top: 0, left: 30, bottom: 40, right: 30)
        case 4:
            return UIEdgeInsets(top: 0, left: 40, bottom: 103, right: 0)
            
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyProfileSectionCollectionViewCell.cellIdentifier, for: indexPath)
                    as? MyProfileSectionCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(data: myProfileData)
            cell.editProfileButton.addTarget(self, action: #selector(editProfileButtonDidTap), for: .touchUpInside)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFamilySectionCollectionViewCell.cellIdentifier, for: indexPath)
                    as? MyFamilySectionCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(myFamilyData: myFamilyMemberData, myProfileData: myProfileData)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPetSectionCollectionViewCell.cellIdentifier, for: indexPath)
                    as? MyPetSectionCollectionViewCell else { return UICollectionViewCell() }
            cell.dataBind(myPetMemberData: myPetMemberData)
            cell.delegate = self
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySettingSectionCollectionViewCell.cellIdentifier, for: indexPath) as? MySettingSectionCollectionViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyDeleteAccountSectionCollectionViewCell.cellIdentifier, for: indexPath)
                    as? MyDeleteAccountSectionCollectionViewCell else { return UICollectionViewCell() }
            cell.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonDidTap), for: .touchUpInside)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - SettingMenuTableViewCellDelegate

extension MyViewController: SettingMenuTableViewCellDelegate {
    func selectedSettingMenuTableViewCell(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            pushToNoticeSettingView()
        case 4:
            pushToAppInformationView()
        case 5:
            logout()
        default:
            break
        }
    }
}

//MARK: - MyRegisterPetButtonTappedDelegate

extension MyViewController: MyRegisterPetButtonTappedDelegate {
    func myRegisterPetButtonTapped(isSelected: Bool) {
        pushToRegisterPetView()
    }
}

extension MyViewController {
    private func pushToEditProfileView() {
        let editProfileViewController = MyEditProfileViewController()
        editProfileViewController.hidesBottomBarWhenPushed = true
        editProfileViewController.dataBind(data: myProfileData)
        
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    private func pushToAppInformationView() {
        let appInformationViewController = MyAppInformationViewController()
        appInformationViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(appInformationViewController, animated: true)
    }
    
    private func pushToNoticeSettingView() {
        let noticeSettingViewController = MyNoticeSettingViewController()
        noticeSettingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(noticeSettingViewController, animated: true)
    }
    
    private func pushToRegisterPetView() {
        let registerPetViewController = MyRegisterPetViewController(myPetRegisterViewModel: MyPetRegisterViewModel())
        registerPetViewController.hidesBottomBarWhenPushed = true
        registerPetViewController.dataSend(myPetMemberData: myPetMemberData)
        self.navigationController?.pushViewController(registerPetViewController, animated: true)
    }
}
