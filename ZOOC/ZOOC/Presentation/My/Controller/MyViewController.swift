//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class  MyViewController : BaseViewController{
    
    //MARK: - Properties
    
    private let profileView = ProfileView()
    private let memberCollectionView = MemberCollectionView()
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
    }
    
    //MARK: - Custom Method
    
    
    private func setUI() {
        view.addSubviews(profileView, memberCollectionView)
    }
    
    private func setLayout() {
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(205)
        }
        
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.profileView.snp.bottom)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(315)
            $0.height.equalTo(155)
        }
    }
    
    private func register() {
    }
    
    //MARK: - Action Method
    
}


