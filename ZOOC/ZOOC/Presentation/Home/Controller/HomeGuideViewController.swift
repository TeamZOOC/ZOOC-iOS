//
//  HomeViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class HomeGuideViewController : BaseViewController{
    
    //MARK: - Properties
    
    private enum Const {
        static let itemSize = CGSize(width: 310, height: 477)
        static let itemSpacing : CGFloat = 13
        
        static var insetX: CGFloat {
          return (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
          return UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
        
        enum ScrollDirection{
            case left
            case right
        }
      }

    //MARK: - UI Components
   
    private lazy var cardCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.contentInset = Const.collectionViewContentInset
        return collectionView
    }()
    
    
    private let progressView : UIView = {
        let view = UIView()
        view.backgroundColor = .zoocLightGreen
        return view
    }()
    
    private let progressTintView : UIView = {
        let view = UIView()
        view.backgroundColor = .zoocDarkGreen
        return view
    }()
    
    private lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(Image.back, for: .normal)
        button.addTarget(self,
                         action: #selector(backButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .zoocMainGreen
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .zoocSubhead1
        button.addTarget(self,
                         action: #selector(nextButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerCell()
        setUI()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setCornerRadius()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
    }
    
    private func registerCell(){
        cardCollectionView.register(
            HomeGuideCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeGuideCollectionViewCell.cellIdentifier)
        
        cardCollectionView.register(
            HomeMissionCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeMissionCollectionViewCell.cellIdentifier)
    }
    
    private func setUI(){
        
    }
    
    private func setLayout(){
        view.addSubviews(backButton, cardCollectionView,progressView,nextButton)
        progressView.addSubview(progressTintView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.height.width.equalTo(25)
        }
            
        cardCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(cardCollectionView.snp.bottom).offset(33)
            $0.leading.trailing.equalToSuperview().inset(75)
            $0.height.equalTo(4)
        }
        
        progressTintView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(progressView.snp.width).dividedBy(2)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview().offset(-40)
            $0.height.equalTo(54)
        }
    }
    
    private func animateTintView(_ direction: Const.ScrollDirection){
      
        var insetX: CGFloat = 0
        
        switch direction{
        case .left:
            insetX = progressView.frame.width / 2
        case .right:
            insetX = 0
        }
        
        UIView.animate(withDuration: 0.3 ) {
            self.progressTintView.transform = CGAffineTransform(translationX: insetX, y: 0)
        }
    }
    
    private func setCornerRadius(){
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap(){
        print("backButtonDidTap")
        navigationController?.popViewController(animated: true)
    }
    @objc private func nextButtonDidTap(){
        print("nextButtonDidTap")
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

//MARK: - UICollectionView DataSource

extension HomeGuideViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item{
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGuideCollectionViewCell.cellIdentifier, for: indexPath) as? HomeGuideCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMissionCollectionViewCell.cellIdentifier, for: indexPath) as? HomeMissionCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default: return UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeGuideViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return Const.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Const.itemSpacing
    }
}

//MARK: - UIScrollViewDelegate

extension HomeGuideViewController{
    
    func scrollViewWillEndDragging( _ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
      
        switch index{
        case 0:
            animateTintView(.right)
        case 1:
            animateTintView(.left)
        default: print("스크롤 에러")
        }
        
      }
}
