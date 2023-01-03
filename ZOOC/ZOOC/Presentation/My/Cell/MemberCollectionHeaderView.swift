////
////  MemberCollectionHeaderView.swift
////  ZOOC
////
////  Created by 류희재 on 2023/01/01.
////
//
//import Foundation
//import UIKit
//
//import SnapKit
//import Then
//
//final class MemberCollectionHeaderView: UICollectionReusableView {
//    
//    static let identifier = "MemberCollectionHeaderView"
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setUI()
//        setLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setUI() {
//        self.backgroundColor = .green
//        addSubviews(memberLabel, inviteButton)
//    }
//    
//    private func setLayout() {
//        memberLabel.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.equalToSuperview()
//        }
//        
//        inviteButton.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(4)
//            $0.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().inset(4)
//        }
//    }
//    
//}
