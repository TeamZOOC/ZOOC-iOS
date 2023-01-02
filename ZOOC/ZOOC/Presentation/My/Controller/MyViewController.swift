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
        
    
    //MARK: - UI Components
    
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
        myView.myCollectionView.register(ProfileView.self, forCellWithReuseIdentifier: ProfileView.identifier)
        myView.myCollectionView.register(FamilyCollectionView.self, forCellWithReuseIdentifier: FamilyCollectionView.identifier)
        myView.myCollectionView.register(PetCollectionView.self, forCellWithReuseIdentifier: PetCollectionView.identifier)
        myView.myCollectionView.register(SettingMenuTableView.self, forCellWithReuseIdentifier: SettingMenuTableView.identifier)
    }
    
    //MARK: - Action Method
    
}

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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileView.identifier, for: indexPath)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyCollectionView.identifier, for: indexPath)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionView.identifier, for: indexPath)
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingMenuTableView.identifier, for: indexPath)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
