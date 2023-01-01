//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class  MyViewController: BaseViewController{
    
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
        myView.myCollectionView.register(MemberCollectionView.self, forCellWithReuseIdentifier: MemberCollectionView.identifier)
        myView.myCollectionView.register(PetCollectionView.self, forCellWithReuseIdentifier: PetCollectionView.identifier)
        myView.myCollectionView.register(SettingMenuTableViewCell.self, forCellWithReuseIdentifier: SettingMenuTableViewCell.identifier)
    }
    
    //MARK: - Action Method
    
}

extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 220)
        case 1:
            return CGSize(width: 315, height: 167)
        case 2:
            return CGSize(width: 315, height: 155)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

extension MyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionView.identifier, for: indexPath)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionView.identifier, for: indexPath)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
