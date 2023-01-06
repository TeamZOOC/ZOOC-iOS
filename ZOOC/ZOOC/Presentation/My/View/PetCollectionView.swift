//
//  PetCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

final class PetCollectionView: UICollectionViewCell {
    
    //MARK: - UI Components
    
    private var petLabel = UILabel().then {
        $0.text = "반려동물"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocSubhead1
    }
    
    private var registerButtonUnderLine = UIView().then {
        $0.backgroundColor = .zoocGray2
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
        addSubviews(petLabel, petCollectionView, registerButtonUnderLine)
        
        petLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }

        petCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.petLabel.snp.bottom).offset(17)
            $0.leading.equalTo(self.petLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(26)
        }
    }
    
    public func register() {
        petCollectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.cellIdentifier)
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension PetCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 86, height: 40)
    }
}

//MARK: - UICollectionViewDataSource

extension PetCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemberModel.petDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionViewCell.cellIdentifier, for: indexPath)
                as? PetCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: MemberModel.petDummyData[indexPath.item])
        return cell
    }
}

