//
//  AnimalCollectionView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/01.
//

//
//  MemberCollectionView.swift
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

    private var registerButton = UIButton().then {
        $0.setTitle("등록하기", for: .normal)
        $0.setTitleColor(.zoocGray2, for: .normal)
        $0.titleLabel!.font = .zoocCaption
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
        register()
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
        addSubviews(petLabel, registerButton, petCollectionView, registerButtonUnderLine)
        
        petLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }

        registerButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(26)
            $0.width.equalTo(42)
            $0.height.equalTo(14)
        }

        petCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.petLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.petLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        registerButtonUnderLine.snp.makeConstraints {
            $0.top.equalTo(self.registerButton.snp.bottom).offset(2)
            $0.trailing.equalTo(self.registerButton)
            $0.width.equalTo(41)
            $0.height.equalTo(1)
        }
        
    }
    
    private func register() {
        petCollectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.cellIdentifier)
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension PetCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 68)
    }
}

//MARK: - UICollectionViewDataSource

extension PetCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionViewCell.cellIdentifier, for: indexPath)
                as? PetCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: petDummyData[indexPath.item])
        return cell
    }
}

