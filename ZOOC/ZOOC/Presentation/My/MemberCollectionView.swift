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
    
    //MARK: - Properties
    
    static let identifier = "MemberCollectionView"
    
    //MARK: - UI Components
    
    private var memberLabel = UILabel().then {
        $0.text = "멤버"
        $0.textColor = UIColor.zoocDarkGray1
        $0.font = UIFont.zoocSubhead1
    }

    private var inviteButton = UIButton().then {
        $0.setTitle("초대하기", for: .normal)
        $0.setTitleColor(UIColor.zoocGray2, for: .normal)
        $0.titleLabel!.font = UIFont.zoocCaption
    }
    
    public lazy var memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.delegate = self
        $0.dataSource = self
    }
    
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
        addSubviews(memberLabel, inviteButton, memberCollectionView)
    }
    
    
    private func setLayout() {
        memberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }

        inviteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(26)
        }

        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.memberLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.memberLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func register() {
        memberCollectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)
    }
}

extension MemberCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 68)
    }
}

extension MemberCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath)
                as? MemberCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
