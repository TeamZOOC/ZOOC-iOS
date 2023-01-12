//
//  MyFamilySectionCollectionViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/11.
//

import UIKit

import SnapKit
import Then

final class MyFamilySectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var myProfileData: MyProfileModel = MyProfileModel(name: "", profileImage: Image.defaultProfile)
    
    private var myFamilyData: [MyUser] = []
    
    //MARK: - UI Components
    
    private var familyLabel = UILabel().then {
        $0.text = "멤버"
        $0.textColor = .zoocDarkGray1
        $0.font = .zoocSubhead1
    }
    
    private var familyCountLabel = UILabel().then {
        $0.text = "\(MyMemberModel.petDummyData.count)/8"
        $0.textColor = .zoocGray2
        $0.font = .zoocCaption
        $0.textAlignment = .center
    }

    private var inviteButton = UIButton().then {
        $0.setTitle("초대하기", for: .normal)
        $0.setTitleColor(.zoocGray2, for: .normal)
        $0.titleLabel!.font = .zoocCaption
    }
    
    private var inviteButtonUnderLine = UIView().then {
        $0.backgroundColor = .zoocGray2
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
        addSubviews(familyLabel, familyCountLabel, inviteButton, familyCollectionView, inviteButtonUnderLine)
        
        familyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(26)
        }
        
        familyCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalTo(self.familyLabel.snp.trailing).offset(4)
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
    
    public func register() {
        familyCollectionView.register(FamilyCollectionViewCell.self, forCellWithReuseIdentifier: FamilyCollectionViewCell.cellIdentifier)
    }
    
    public func dataBind(myFamilyData: [MyUser]) {
        self.myProfileData = myProfileData
        self.myFamilyData = myFamilyData
        print("👨‍👩‍👧‍👦👨‍👩‍👧‍👦 우리 가족이 섹션셀에 들어왔어요 \(myFamilyData)")
        print("👨‍👩‍👧‍👦👨‍👩‍👧‍👦 우리 가족이 섹션셀에 들어온 명수는? \(myFamilyData.count)")

        self.familyCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MyFamilySectionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 68)
    }
}

//MARK: - UICollectionViewDataSource
extension MyFamilySectionCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFamilyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyCollectionViewCell.cellIdentifier, for: indexPath)
                as? FamilyCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: myFamilyData[indexPath.item], index: indexPath.item, myProfileData: myProfileData)
        return cell
    }
}
