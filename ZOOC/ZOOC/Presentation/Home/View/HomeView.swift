//
//  HomeView.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/21.
//

import UIKit

import SnapKit
import Then

final class HomeView : UIView{
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    public let missionView = UIView()
    public let missionWordLabel = UILabel()
    public let missionLabel = UILabel()
    public let noticeButton = UIButton()
    
    public let petCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    public let listButton = UIButton()
    public let gridButton = UIButton()
    
    public let archiveListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    public let archiveGridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    public let archiveBottomView = UIView()
    public let archiveIndicatorView = HomeArchiveIndicatorView()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    
    private func style() {
        
        missionWordLabel.do {
            $0.text = "미션"
            $0.font = .zoocSubhead1
            $0.textColor = .zoocMainGreen
        }
        
        missionLabel.do {
            $0.font = .zoocBody3
            $0.textColor = .zoocGray3
        }
        
        noticeButton.do {
            $0.setImage(Image.ring, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        petCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
            
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
        
        listButton.do {
            $0.isSelected = true
            $0.tintColor = .systemPink
            $0.setImage(Image.list, for: .normal)
            $0.setImage(Image.listFill, for: .selected)
        }
        
        gridButton.do {
            $0.setImage(Image.grid, for: .normal)
            $0.setImage(Image.gridFill, for: .selected)
        }
        
        archiveListCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.collectionViewLayout = layout
            
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
        
        archiveGridCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            $0.collectionViewLayout = layout
            
            $0.isHidden = true
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
   
    
    private func hierarchy() {
        
        self.addSubviews(missionView,
                         petCollectionView,
                         listButton,
                         gridButton,
                         archiveBottomView,
                         archiveListCollectionView,
                         archiveGridCollectionView)
                          
        
        missionView.addSubviews(missionWordLabel,
                                missionLabel,
                                noticeButton)
                                
        
        archiveBottomView.addSubview(archiveIndicatorView)
    }
    
    private func layout() {
        
        //MARK: rootView
        
        missionView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        listButton.snp.makeConstraints {
            $0.centerY.equalTo(petCollectionView)
            $0.trailing.equalTo(gridButton.snp.leading)
            $0.height.width.equalTo(36)
        }
        
        gridButton.snp.makeConstraints {
            $0.centerY.equalTo(petCollectionView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(36)
        }
        
        petCollectionView.snp.makeConstraints {
            $0.top.equalTo(missionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalTo(listButton.snp.leading)
            $0.height.equalTo(40)
        }
        
        archiveListCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(petCollectionView.snp.bottom).offset(29)
            $0.height.equalTo(438)
        }
        
        archiveGridCollectionView.snp.makeConstraints {
            $0.edges.equalTo(archiveListCollectionView)
        }
        
        archiveBottomView.snp.makeConstraints {
            $0.top.equalTo(archiveListCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        //MARK: missionView
        
        missionWordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }
        
        missionLabel.snp.makeConstraints {
            $0.leading.equalTo(missionWordLabel.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        noticeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(42)
        }
        
        //MARK: archiveBottomView
        
        archiveIndicatorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(72)
            $0.height.equalTo(4)
        }
    }
    
}
