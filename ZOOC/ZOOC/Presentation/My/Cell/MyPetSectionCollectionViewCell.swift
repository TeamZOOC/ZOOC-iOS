//
//  PetCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

protocol MyRegisterPetButtonTappedDelegate {
    func myRegisterPetButtonTapped(isSelected: Bool)
}

final class MyPetSectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var delegate: MyRegisterPetButtonTappedDelegate?
    
    private let myRegisterPetView = MyRegisterPetView()
    
    private lazy var myPetMemberData: [MyPet] = []
    
    //MARK: - UI Components
    
    private var petLabel = UILabel().then {
        $0.text = "반려동물"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocSubhead1
    }
    
    public var petCountLabel = UILabel().then {
//        $0.text = "\(myPetMemberData.count)/4"
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
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
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

extension MyPetSectionCollectionViewCell: RegisterPetButtonTappedDelegate {
    func registerPetButtonTapped(isSelected: Bool) {
        if isSelected {
            delegate?.myRegisterPetButtonTapped(isSelected: isSelected)
        }
    }
}

