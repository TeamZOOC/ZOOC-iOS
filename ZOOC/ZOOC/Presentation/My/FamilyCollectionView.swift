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

final class FamilyCollectionView: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "MemberCollectionView"
    
    //MARK: - UI Components
    
    private var familyLabel = UILabel().then {
        $0.text = "멤버"
        $0.textColor = UIColor.zoocDarkGray1
        $0.font = UIFont.zoocSubhead1
    }

    private var inviteButton = UIButton().then {
        $0.setTitle("초대하기", for: .normal)
        $0.setTitleColor(UIColor.zoocGray2, for: .normal)
        $0.titleLabel!.font = UIFont.zoocCaption
    }
    
    private var inviteButtonUnderLine = UIView().then {
        $0.backgroundColor = UIColor.zoocGray2
    }
    
    public lazy var familyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
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
        self.backgroundColor = .green
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        addSubviews(familyLabel, inviteButton, familyCollectionView, inviteButtonUnderLine)
    }
    
    
    private func setLayout() {
        familyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }

        inviteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(26)
            $0.width.equalTo(42)
            $0.height.equalTo(14)
        }
        
        inviteButtonUnderLine.snp.makeConstraints {
            $0.top.equalTo(self.inviteButton.snp.bottom).offset(2)
            $0.trailing.equalTo(self.inviteButton)
            $0.width.equalTo(41)
            $0.height.equalTo(1)
        }

        familyCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.familyLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.familyLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func register() {
        familyCollectionView.register(FamilyCollectionViewCell.self, forCellWithReuseIdentifier: FamilyCollectionViewCell.identifier)
    }
}

extension FamilyCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 68)
    }
}

extension FamilyCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return familyDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyCollectionViewCell.identifier, for: indexPath)
                as? FamilyCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: familyDummyData[indexPath.item])
        return cell
    }
}
