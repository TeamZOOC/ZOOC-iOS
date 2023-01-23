//
//  MyView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

final class MyView: UIView  {
    
    //MARK: - UI Components
    
    public lazy var myCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isScrollEnabled = true
            $0.showsVerticalScrollIndicator = false
            $0.alwaysBounceVertical = true
        }
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        myCollectionView.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        addSubviews(myCollectionView)
        
        myCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func register() {
        myCollectionView.register(
            MyProfileSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: MyProfileSectionCollectionViewCell.cellIdentifier)
        myCollectionView.register(
            MyFamilySectionCollectionViewCell.self,
            forCellWithReuseIdentifier: MyFamilySectionCollectionViewCell.cellIdentifier)
        myCollectionView.register(
            MyPetSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: MyPetSectionCollectionViewCell.cellIdentifier)
        myCollectionView.register(
            MySettingSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: MySettingSectionCollectionViewCell.cellIdentifier)
        myCollectionView.register(
            MyDeleteAccountSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: MyDeleteAccountSectionCollectionViewCell.cellIdentifier)
    }
}



