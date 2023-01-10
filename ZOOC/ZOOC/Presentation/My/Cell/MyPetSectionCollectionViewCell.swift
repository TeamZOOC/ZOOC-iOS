//
//  PetCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

final class MyPetSectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI Components
    
    private var petLabel = UILabel().then {
        $0.text = "반려동물"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocSubhead1
    }
    
    private var petCountLabel = UILabel().then {
        $0.text = "\(MemberModel.petDummyData.count)/4"
        $0.textColor = .zoocGray2
        $0.font = .zoocCaption
        $0.textAlignment = .center
    }
    
    public lazy var petCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.delegate = self
        $0.dataSource = self
    }
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    private func setLayout() {
        addSubviews(petLabel, petCountLabel, petCollectionView)
        
        petLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }
        
        petCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalTo(self.petLabel.snp.trailing).offset(4)
        }
        
        petCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.petLabel.snp.bottom).offset(17)
            $0.leading.equalTo(self.petLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(26)
        }
    }
    
    public func register() {
        petCollectionView.register(MyPetCollectionViewCell.self, forCellWithReuseIdentifier: MyPetCollectionViewCell.cellIdentifier)
        
        petCollectionView.register(MyPetCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MyPetCollectionFooterView.reuseCellIdentifier)
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension MyPetSectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 86, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        print(#function)
        return CGSize(width: 11, height: 11)
    }
}

//MARK: - UICollectionViewDataSource

extension MyPetSectionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemberModel.petDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPetCollectionViewCell.cellIdentifier, for: indexPath)
                as? MyPetCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: MemberModel.petDummyData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print(#function)
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPetCollectionFooterView.reuseCellIdentifier, for: indexPath) as? MyPetCollectionFooterView else { return UICollectionReusableView() }
        return footer
    }
}

