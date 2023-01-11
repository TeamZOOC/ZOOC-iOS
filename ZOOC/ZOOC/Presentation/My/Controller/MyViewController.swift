//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class MyViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var myProfileData: MyProfileModel = MyProfileModel(name: "복실맘",
                                                               email: "fbgmlwo123@naver.com",
                                                               profileImage: Image.defaultProfile)
    
    
    //MARK: - UI Components
    
    private lazy var myView = MyView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        print(self)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tabBarController?.tabBar.isHidden = false
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = true
//    }
    
    
    //MARK: - Custom Method
    
    private func register() {
        myView.myCollectionView.delegate = self
        myView.myCollectionView.dataSource = self
        
        myView.myCollectionView.register(ProfileView.self, forCellWithReuseIdentifier: ProfileView.cellIdentifier)
        myView.myCollectionView.register(FamilyCollectionView.self, forCellWithReuseIdentifier: FamilyCollectionView.cellIdentifier)
        myView.myCollectionView.register(PetCollectionView.self, forCellWithReuseIdentifier: PetCollectionView.cellIdentifier)
        myView.myCollectionView.register(SettingMenuTableView.self, forCellWithReuseIdentifier: SettingMenuTableView.cellIdentifier)
        myView.myCollectionView.register(DeleteAccountView.self, forCellWithReuseIdentifier: DeleteAccountView.cellIdentifier)
    }
    
    private func pushToEditProfileView() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.hidesBottomBarWhenPushed = true
        editProfileViewController.dataSend(profileName: myProfileData.name,
                                           profileImage: myProfileData.profileImage)
        
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    private func pushToAppInformationView() {
        let appInformationViewController = AppInformationViewController()
        appInformationViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(appInformationViewController, animated: true)
    }
    
    private func pushToNoticeSettingView() {
        let noticeSettingViewController = MyNoticeSettingViewController()
        noticeSettingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(noticeSettingViewController, animated: true)
    }
    
    func dataSend(profileName: String, profileImage: UIImage) {
        myProfileData.name = profileName
        myProfileData.profileImage = profileImage
        myView.myCollectionView.reloadData()
    }
    
    //MARK: - Action Method
    
    @objc
    private func editProfileButtonDidTap() {
        pushToEditProfileView()
    }
    
    @objc
    private func appInformationButtonDidTap() {
        pushToAppInformationView()
    }
    
    @objc
    func deleteAccountButtonDidTap() {
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
            return UIEdgeInsets(top: 0, left: 30, bottom: 6, right: 30)
        case 3:
            return UIEdgeInsets(top: 0, left: 30, bottom: 40, right: 30)
        case 4:
            return UIEdgeInsets(top: 0, left: 50, bottom: 103, right: 0)
            
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileView.cellIdentifier, for: indexPath)
                    as? ProfileView else { return UICollectionViewCell() }
            cell.dataBind(data: myProfileData)
            cell.editProfileButton.addTarget(self, action: #selector(editProfileButtonDidTap), for: .touchUpInside)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyCollectionView.cellIdentifier, for: indexPath)
                    as? FamilyCollectionView else { return UICollectionViewCell() }
            cell.register()
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionView.cellIdentifier, for: indexPath)
                    as? PetCollectionView else { return UICollectionViewCell() }
            cell.register()
            return cell
            
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingMenuTableView.cellIdentifier, for: indexPath) as? SettingMenuTableView else { return UICollectionViewCell() }
            cell.register()
            cell.delegate = self
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeleteAccountView.cellIdentifier, for: indexPath)
                    as? DeleteAccountView else { return UICollectionViewCell() }
            cell.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonDidTap), for: .touchUpInside)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension MyViewController: SettingMenuTableViewCellDelegate {
    func selectedSettingMenuTableViewCell(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            pushToNoticeSettingView()
        case 4:
            pushToAppInformationView()
        default:
            break
        }
    }
}
