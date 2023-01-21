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
    
    private var petMockData: [HomePetModel] = HomePetModel.mockData
    private var archiveMockData: [HomeArchiveModel] = HomeArchiveModel.mockData
    
    private var petData: [HomePetResult] = [] {
        didSet{
            petCollectionView.reloadData()
        }
    }
    private var archiveData: [HomeArchiveResult] = []{
        didSet{
            archiveListCollectionView.reloadData()
            archiveGridCollectionView.reloadData()
        }
    }
    
    //MARK: - UI Components
    
    private let missionView = UIView()
    private let missionWordLabel = UILabel()
    private let missionLabel = UILabel()
    private let noticeButton = UIButton()
    
    private let petCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
                                                    
    private let listButton = UIButton()
    private let gridButton = UIButton()
    
    private let archiveListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let archiveGridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private let archiveBottomView = UIView()
    private let archiveIndicatorView = HomeArchiveIndicatorView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        gesture()
        
        style()
        hierarchy()
        layout()
        
        autoSelectPetCollectionView()
        requestMissionAPI()
        requestTotalPetAPI()
    }
    
    //MARK: - Custom Method
    
    private func register(){
        petCollectionView.delegate = self
        petCollectionView.dataSource = self
        
        archiveListCollectionView.delegate = self
        archiveListCollectionView.dataSource = self
        archiveGridCollectionView.delegate = self
        archiveGridCollectionView.dataSource = self
        
        petCollectionView.register(HomePetCollectionViewCell.self,
                                   forCellWithReuseIdentifier:HomePetCollectionViewCell.cellIdentifier)
        
        archiveListCollectionView.register(HomeArchiveListCollectionViewCell.self,
                                           forCellWithReuseIdentifier: HomeArchiveListCollectionViewCell.cellIdentifier)
        
        archiveGridCollectionView.register(HomeArchiveGridCollectionViewCell.self,
                                           forCellWithReuseIdentifier: HomeArchiveGridCollectionViewCell.cellIdentifier)
    }
    
    private func gesture(){
        noticeButton.addTarget(self,
                               action: #selector(noticeButtonDidTap),
                               for: .touchUpInside)
        listButton.addTarget(self,
                             action: #selector(listButtonDidTap),
                             for: .touchUpInside)
        
        gridButton.addTarget(self,
                             action: #selector(galleryButtonDidTap),
                             for: .touchUpInside)
        
        archiveBottomView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(bottomViewDidTap)))
    }
    
    private func style(){
        
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
   
    
    private func hierarchy(){
        
        view.addSubviews(missionView,
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
    
    private func layout(){
        
        //MARK: rootView
        missionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
    
    private func pushToDetailViewController(recordID: String){
        guard let index = petCollectionView.indexPathsForSelectedItems?[0].row else {
            presentBottomAlert("선택된 펫이 없습니다.")
            return
        }
        
        let detailVC = HomeDetailArchiveViewController()
        let petID = String(petData[index].id)
        detailVC.petID = petID
        detailVC.getAPI(recordID: recordID, petID: petID)
        
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func pushToHomeAlarmViewController(){
        let noticeVC = HomeNoticeViewController()
        noticeVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(noticeVC, animated: true)
    }
    
    private func deselectAllOfListArchiveCollectionViewCell(){
        archiveListCollectionView.indexPathsForSelectedItems?
            .forEach { archiveListCollectionView.deselectItem(at: $0, animated: false) }
        archiveListCollectionView.performBatchUpdates(nil, completion: nil)
    }
    
    private func autoSelectPetCollectionView(){
        if petData.count != 0 {
            petCollectionView.selectItem(at: IndexPath(row: 0, section: 0),
                                         animated: false,
                                         scrollPosition: .centeredHorizontally)
            petCollectionView.performBatchUpdates(nil)
            requestTotalArchiveAPI(petID: petData[0].id)
        }
    }
    
    private func configIndicatorViewBarWidth(_ scrollView: UIScrollView){
        let allWidth = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
        let showingWidth = scrollView.bounds.width
        
        self.archiveIndicatorView.widthRatio = showingWidth / allWidth
        self.archiveIndicatorView.layoutIfNeeded()
    }
    
    //MARK: - Network
    
    private func requestMissionAPI(){
        HomeAPI.shared.getMission(familyID: User.familyID) { result in
            
            guard let result = self.validateResult(result) as? [HomeMissionResult] else { return }
            
            self.missionLabel.text = result[0].missionContent //TODO: 미션용 API 필요
        }
    }

    func requestTotalPetAPI(){
        HomeAPI.shared.getTotalPet(familyID: User.familyID) { result in
            
            guard let result = self.validateResult(result) as? [HomePetResult] else { return }
            
            self.petData = result
            
            DispatchQueue.main.async {
                self.autoSelectPetCollectionView()
            }
            
        }
    }
    
    private func requestTotalArchiveAPI(petID: Int){
        HomeAPI.shared.getTotalArchive(petID: String(petID)) { result in
            
            guard let result = self.validateResult(result) as? [HomeArchiveResult] else { return }
            
            self.archiveData = result
            
            DispatchQueue.main.async {
                self.configIndicatorViewBarWidth(self.archiveListCollectionView)
            }
        }
    }
    
    
    //MARK: - Action Method
    
    @objc
    private func noticeButtonDidTap(){
        pushToHomeAlarmViewController()
    }
    
    @objc
    private func listButtonDidTap(){
        archiveListCollectionView.isHidden = false
        archiveGridCollectionView.isHidden = true
        archiveBottomView.isHidden = false
        listButton.isSelected = true
        gridButton.isSelected = false
        
        archiveListCollectionView.snp.remakeConstraints {
            $0.top.equalTo(petCollectionView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(438)
        }
    }
    
    @objc
    private func galleryButtonDidTap(){
        archiveListCollectionView.isHidden = true
        archiveGridCollectionView.isHidden = false
        archiveBottomView.isHidden = true
        
        listButton.isSelected = false
        gridButton.isSelected = true
        
        archiveListCollectionView.snp.remakeConstraints {
            $0.top.equalTo(petCollectionView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func bottomViewDidTap(){
        deselectAllOfListArchiveCollectionViewCell()
    }
    
    
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == petCollectionView{
            return petData.count
        }
        
        if collectionView == archiveListCollectionView{
            return archiveData.count
        }
        
        if collectionView == archiveGridCollectionView{
            return archiveData.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == petCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePetCollectionViewCell.cellIdentifier,
                                                                for: indexPath) as?  HomePetCollectionViewCell else { return UICollectionViewCell() }
            
            cell.dataBind(data: petData[indexPath.item])
            return cell
        }
        
        if collectionView == archiveListCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeArchiveListCollectionViewCell.cellIdentifier,
                                                                for: indexPath) as?  HomeArchiveListCollectionViewCell else { return UICollectionViewCell() }
            
            cell.dataBind(data: archiveData[indexPath.item])
            cell.updateWriterCollectionViewCell()
            return cell
        }
        
        if collectionView == archiveGridCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeArchiveGridCollectionViewCell.cellIdentifier,
                                                                for: indexPath) as?  HomeArchiveGridCollectionViewCell else { return UICollectionViewCell() }
            
            cell.dataBind(data: archiveData[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

//MARK: - UICollectionViewDelegate

extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        if collectionView == archiveListCollectionView{
            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeArchiveListCollectionViewCell else { return false }
            
            switch cell.viewType{
            case .folded:
                return true
            case .expanded:
                let id = String(archiveData[indexPath.item].record.id)
                pushToDetailViewController(recordID: id)
                return false
            }
        }
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == petCollectionView{
            collectionView.performBatchUpdates(nil)
            requestTotalArchiveAPI(petID: petData[indexPath.row].id )
            
        }
        
        if collectionView == archiveListCollectionView{
            collectionView.performBatchUpdates(nil)
        }
        
        if collectionView == archiveGridCollectionView{
            let id = String(archiveData[indexPath.item].record.id)
            pushToDetailViewController(recordID: id)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath)
    {
        if collectionView == petCollectionView{
            collectionView.performBatchUpdates(nil)
        }
        
        if collectionView == archiveListCollectionView{
            collectionView.performBatchUpdates(nil)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == petCollectionView{
            switch collectionView.indexPathsForSelectedItems?.first {
            case .some(indexPath):
                guard let cell = collectionView.cellForItem(at: indexPath) as? HomePetCollectionViewCell else { return .zero}
                cell.dataBind(data: petData[indexPath.item])
                return cell.sizeFittingWith(cellHeight: 40)
            default:
                return CGSize(width: 40, height: 40)
            }
        }
        
        if collectionView == archiveListCollectionView{
            switch collectionView.indexPathsForSelectedItems?.first {
            case .some(indexPath):
                return CGSize(width: 195, height: 436)
            default:
                return CGSize(width: 60, height: 436)
            }
        }
        
        if collectionView == archiveGridCollectionView{
            return CGSize(width: 100, height: 100)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        if collectionView == petCollectionView{
            return 4
        }
        
        if collectionView == archiveListCollectionView{
            return 11
        }
        if collectionView == archiveGridCollectionView{
            return 10
        }
        
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == petCollectionView{
            return .zero
        }
        
        if collectionView == archiveListCollectionView{
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
        
        if collectionView == archiveGridCollectionView{
            return UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 30)
        }
        
        return .zero
        
    }
}

//MARK: - ScrollViewDelegate

extension HomeViewController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == archiveListCollectionView{
            
            let scroll = scrollView.contentOffset.x + scrollView.contentInset.left
            let width = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
            let scrollRatio = scroll / width
            
            self.archiveIndicatorView.leftOffsetRatio = scrollRatio
        }
    }
}
