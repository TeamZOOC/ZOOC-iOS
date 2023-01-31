//
//  PetCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

//MARK: - MyRegisterPetButtonTappedDelegate

protocol MyRegisterPetButtonTappedDelegate {
    func myRegisterPetButtonTapped(isSelected: Bool)
}

final class MyPetSectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var delegate: MyRegisterPetButtonTappedDelegate?
    private let myRegisterPetView = MyRegisterPetView()
    private lazy var myPetMemberData: [MyPet] = []
    
    //MARK: - UI Components
    
    private var petLabel = UILabel()
    public var petCountLabel = UILabel()
    public lazy var petCollectionView = UICollectionView(frame: .zero)
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func register() {
        petCollectionView.delegate = self
        petCollectionView.dataSource = self

        petCollectionView.register(
            MyPetCollectionViewCell.self,
            forCellWithReuseIdentifier: MyPetCollectionViewCell.cellIdentifier)
        
        petCollectionView.register(
            MyPetCollectionFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MyPetCollectionFooterView.reuseCellIdentifier)
    }
    
    private func style() {
        self.do {
            $0.backgroundColor = .white
            $0.makeCornerRadius(ratio: 12)
        }
        
        petLabel.do {
            $0.text = "반려동물"
            $0.textColor = .zoocDarkGray1
            $0.font = .zoocSubhead1
        }
        
        petCountLabel.do {
            $0.textColor = .zoocGray2
            $0.font = .zoocCaption
            $0.textAlignment = .center
        }
        
        petCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.showsHorizontalScrollIndicator = false
            $0.collectionViewLayout = layout
        }
    }
    
    private func hierarchy() {
        addSubviews(petLabel, petCountLabel, petCollectionView)
    }
    
    private func layout() {
        petLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }
        
        petCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalTo(self.petLabel.snp.trailing).offset(4)
        }
        
        petCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.petLabel.snp.bottom).offset(17)
            $0.leading.equalTo(self.petLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(26)
        }
    }
    
    public func dataBind(myPetMemberData : [MyPet]) {
        self.myPetMemberData = myPetMemberData
        petCountLabel.text = "\(myPetMemberData.count)/4"
        self.petCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MyPetSectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 86, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        print(#function)
        return CGSize(width: 70, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
}

//MARK: - UICollectionViewDataSource

extension MyPetSectionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPetMemberData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPetCollectionViewCell.cellIdentifier, for: indexPath)
                as? MyPetCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: myPetMemberData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPetCollectionFooterView.reuseCellIdentifier, for: indexPath) as? MyPetCollectionFooterView else { return UICollectionReusableView() }
        footer.delegate = self
        return footer
    }
}

//MARK: - RegisterPetButtonTappedDelegate

extension MyPetSectionCollectionViewCell: RegisterPetButtonTappedDelegate {
    func registerPetButtonTapped(isSelected: Bool) {
        delegate?.myRegisterPetButtonTapped(isSelected: isSelected)
    }
}

