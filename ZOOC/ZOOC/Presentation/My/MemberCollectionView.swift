//
//  MemberCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import Foundation
import UIKit

import SnapKit
import Then

final class MemberCollectionView: UICollectionViewCell {
    
    public lazy var memberCollectionView = UICollectionView().then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.delegate = self
        $0.dataSource = self
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        addSubview(memberCollectionView)
    }
    
    
    private func setLayout() {
        memberCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func register() {
        memberCollectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)
    }
}

extension MemberCollectionView: UICollectionViewDelegateFlowLayout {}

extension MemberCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath)
                as? MemberCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
