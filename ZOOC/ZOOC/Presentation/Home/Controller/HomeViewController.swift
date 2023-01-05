//
//  uivc.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class HomeViewController : BaseViewController{
    
    //MARK: - Properties
    
    
    //MARK: - UI Components
    
    private let missionView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let missionWordLabel : UILabel = {
        let label = UILabel()
        label.text = "미션"
        label.textColor = .zoocMainGreen
        return label
    }()
    
    private let missionLabel : UILabel = {
        let label = UILabel()
        label.text = "포미와 사진을 찍어보세요"
        label.textColor = .zoocGray2 //ZOOCGray3
        return label
    }()
    
    private lazy var noticeButton : UIButton = {
        let button = UIButton()
        button.setImage(Image.ring, for: .normal)
        button.addTarget(self, action: #selector(noticeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let petCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var listButton : UIButton = {
        let button = UIButton()
        button.setImage(Image.list, for: .normal)
        button.addTarget(self, action: #selector(listButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var galleryButton : UIButton = {
        let button = UIButton()
        button.setImage(Image.grid, for: .normal)
        button.addTarget(self, action: #selector(galleryButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let recordCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    //TODO: 인디게이터 바 구현부
    
    private lazy var mainStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.backgroundColor = .green
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        register()
    }
    
    //MARK: - Custom Method
    
    private func register(){
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
        
        recordCollectionView.register(HomeRecordCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecordCollectionViewCell.cellIdentifier)
        
    }
    
    private func setUI(){
        
    }
    
    private func setLayout(){
        
        mainStackView.addArrangedSubViews(recordCollectionView,bottomView)
        view.addSubviews(
                        missionView,
                        petCollectionView,
                        listButton,
                        galleryButton,
                        mainStackView
        )
        
        missionView.addSubviews(
                                missionWordLabel,
                                missionLabel,
                                noticeButton
                                )
        
        missionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
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
        }
        
        petCollectionView.snp.makeConstraints {
            $0.top.equalTo(missionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalTo(listButton.snp.leading)
            $0.height.equalTo(40)
        }
        
        listButton.snp.makeConstraints {
            $0.centerY.equalTo(petCollectionView)
            $0.trailing.equalTo(galleryButton.snp.leading)
            $0.height.width.equalTo(36)
        }
        
        galleryButton.snp.makeConstraints {
            $0.centerY.equalTo(petCollectionView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(36)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(petCollectionView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        recordCollectionView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(100)
        }
        
        bottomView.snp.makeConstraints {
            $0.height.equalTo(82)
        }
    }
    
    private func pushToDetailViewController(){
        let viewController = HomeDetailArchiveViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
        print("HomeDetailArchiveViewController 로 화면전환합니다")
    }
    
    //MARK: - Action Method
    
    @objc private func noticeButtonDidTap(){
        print(#function)
    }
    
    @objc private func listButtonDidTap(){
        recordCollectionView.indexPathsForSelectedItems?
            .forEach { recordCollectionView.deselectItem(at: $0, animated: false) }
        recordCollectionView.performBatchUpdates(nil, completion: nil)
        recordCollectionView.layoutIfNeeded()
    }
    
    @objc private func galleryButtonDidTap(){
        print(#function)
    }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeRecordModel.mockData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecordCollectionViewCell.cellIdentifier, for: indexPath) as?  HomeRecordCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(.folded, data: HomeRecordModel.mockData[indexPath.item])
        cell.dataBind(indexPath)
        print("\(indexPath.row)번째 - cellForItemAt")
        return cell
    }

}

//MARK: - UICollectionViewDelegate

extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeRecordCollectionViewCell else { return false }
        //print("\(indexPath.row)번째 \(cell.viewType) Cell - shouldSelectItemAt 호출됨 ")
        switch cell.viewType{
        case .folded:
            return true
        case .expanded:
            pushToDetailViewController()
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath)
    {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        switch collectionView.indexPathsForSelectedItems?.first {
           case .some(indexPath):
               return CGSize(width: 195, height: 436)
           default:
               return CGSize(width: 60, height: 436)
           }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }


}
