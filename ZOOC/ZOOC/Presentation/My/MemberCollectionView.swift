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

final class MemberCollectionView: UICollectionView {
    public lazy var memberCollectionView =
    UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
//        $0.delegate = self
//        $0.dataSource = self
    }
}
