//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class  MyViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var myView = MyView()
    private lazy var profileView = ProfileView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        myView.myCollectionView.delegate = self
        myView.myCollectionView.dataSource = self
        myView.myCollectionView.register(ProfileView.self, forCellWithReuseIdentifier: ProfileView.cellIdentifier)
        myView.myCollectionView.register(FamilyCollectionView.self, forCellWithReuseIdentifier: FamilyCollectionView.cellIdentifier)
        myView.myCollectionView.register(PetCollectionView.self, forCellWithReuseIdentifier: PetCollectionView.cellIdentifier)
        myView.myCollectionView.register(SettingMenuTableView.self, forCellWithReuseIdentifier: SettingMenuTableView.cellIdentifier)
    }
    
    private func target() {
        profileView.editProfileButton.addTarget(self, action: #selector(editProfileButtonDidTap), for: .touchUpInside)
    }
    
    private func pushToAppInformationView() {
        let appInformationViewController = AppInformationViewController()
        self.navigationController?.pushViewController(appInformationViewController, animated: true)
    }
    
    private func pushToEditProfileView() {
        let editProfileViewController = EditProfileViewController()
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
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
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 220)
        case 1:
            return CGSize(width: 315, height: 155)
        case 2:
            return CGSize(width: 315, height: 155)
        case 3:
            return CGSize(width: 315, height: 402)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 30, bottom: 12, right: 30)
        case 2:
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        case 3:
            return UIEdgeInsets(top: 0, left: 30, bottom: 42, right: 30)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileView.cellIdentifier, for: indexPath)
                    as? ProfileView else { return UICollectionViewCell() }
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
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//extension MyViewController: SettingMenuTableViewCellDelegate {
//    func selectedSettingMenuTableViewCell(_ tableView: UITableView, _ index: Int) {
//        print("yes")
//        let appInformationViewController = AppInformationViewController()
//        appInformationViewController.modalPresentationStyle = .overFullScreen
//        appInformationViewController.modalTransitionStyle = .crossDissolve
//        present(appInformationViewController, animated: true, completion: nil)
//
//        //self.navigationController?.pushViewController(appInformationViewController, animated: true)
//    }
//}
