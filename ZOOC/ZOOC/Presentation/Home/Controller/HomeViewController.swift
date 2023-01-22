//
//  uivc.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class HomeViewController : BaseViewController {
    
    //MARK: - Properties
    
    private var petData: [HomePetResult] = [] {
        didSet{
            rootView.petCollectionView.reloadData()
        }
    }
    private var archiveData: [HomeArchiveResult] = []{
        didSet{
            rootView.archiveListCollectionView.reloadData()
            rootView.archiveGridCollectionView.reloadData()
        }
    }
    //MARK: - UI Components
    
    private let rootView = HomeView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        gesture()
        
        requestMissionAPI()
        requestTotalPetAPI()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        rootView.petCollectionView.delegate = self
        rootView.petCollectionView.dataSource = self
        
        rootView.archiveListCollectionView.delegate = self
        rootView.archiveListCollectionView.dataSource = self
        rootView.archiveGridCollectionView.delegate = self
        rootView.archiveGridCollectionView.dataSource = self
        
        rootView.petCollectionView.register(HomePetCollectionViewCell.self,
                                            forCellWithReuseIdentifier:HomePetCollectionViewCell.cellIdentifier)
        
        rootView.archiveListCollectionView.register(HomeArchiveListCollectionViewCell.self,
                                                    forCellWithReuseIdentifier: HomeArchiveListCollectionViewCell.cellIdentifier)
        
        rootView.archiveGridCollectionView.register(HomeArchiveGridCollectionViewCell.self,
                                           forCellWithReuseIdentifier: HomeArchiveGridCollectionViewCell.cellIdentifier)
    }
    
    private func gesture() {
        rootView.noticeButton.addTarget(self,
                               action: #selector(noticeButtonDidTap),
                               for: .touchUpInside)
        rootView.listButton.addTarget(self,
                             action: #selector(listButtonDidTap),
                             for: .touchUpInside)
        
        rootView.gridButton.addTarget(self,
                             action: #selector(galleryButtonDidTap),
                             for: .touchUpInside)
        
        rootView.archiveBottomView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(bottomViewDidTap)))
    }
    
    
    private func pushToDetailViewController(recordID: String) {
        guard let index = rootView.petCollectionView.indexPathsForSelectedItems?[0].item else {
            presentBottomAlert("선택된 펫이 없습니다.")
            return
        }
        
        let detailVC = HomeDetailArchiveViewController()
        let petID = String(petData[index].id)
        detailVC.petID = petID
        detailVC.requestDetailArchiveAPI(recordID: recordID, petID: petID)
        
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func pushToHomeAlarmViewController() {
        let noticeVC = HomeNoticeViewController()
        noticeVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(noticeVC, animated: true)
    }
    
    private func deselectAllOfListArchiveCollectionViewCell() {
        rootView.archiveListCollectionView.indexPathsForSelectedItems?
            .forEach { rootView.archiveListCollectionView.deselectItem(at: $0, animated: false) }
        rootView.archiveListCollectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func selectPetCollectionView(petID: Int) {
        var index = 0
        for pet in petData{
            if pet.id == petID{ break }
            index += 1
        }
        
        guard index < petData.count else { return }
    
        rootView.petCollectionView.selectItem(at:IndexPath(item: index, section: 0),
                                     animated: false,
                                     scrollPosition: .centeredHorizontally)
        rootView.petCollectionView.performBatchUpdates(nil)
        requestTotalArchiveAPI(petID: petData[index].id)
    }
    
    private func configIndicatorBarWidth(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5) {
            let allWidth = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
            let showingWidth = scrollView.bounds.width
            self.rootView.archiveIndicatorView.widthRatio = showingWidth / allWidth
            self.rootView.archiveIndicatorView.layoutIfNeeded()
        }
    }
    
    //MARK: - Network
    
    private func requestMissionAPI() {
        HomeAPI.shared.getMission(familyID: User.familyID) { result in
            
            guard let result = self.validateResult(result) as? [HomeMissionResult] else { return }
            
            self.rootView.missionLabel.text = result[0].missionContent //TODO: 미션용 API 필요
        }
    }

    private func requestTotalPetAPI() {
        HomeAPI.shared.getTotalPet(familyID: User.familyID) { result in
            
            guard let result = self.validateResult(result) as? [HomePetResult] else { return }
            
            self.petData = result
            guard let id = self.petData.first?.id else { return }
            
            DispatchQueue.main.async {
                self.selectPetCollectionView(petID: id)
            }
            
        }
    }
    
    public func requestTotalArchiveAPI(petID: Int) {
        HomeAPI.shared.getTotalArchive(petID: String(petID)) { result in
            
            guard let result = self.validateResult(result) as? [HomeArchiveResult] else { return }
            
            self.archiveData = result
            
            DispatchQueue.main.async {
                self.configIndicatorBarWidth(self.rootView.archiveListCollectionView)
            }
        }
    }
    
    
    //MARK: - Action Method
    
    @objc
    private func noticeButtonDidTap() {
        pushToHomeAlarmViewController()
    }
    
    @objc
    private func listButtonDidTap() {
        rootView.archiveListCollectionView.isHidden = false
        rootView.archiveGridCollectionView.isHidden = true
        rootView.archiveBottomView.isHidden = false
        rootView.listButton.isSelected = true
        rootView.gridButton.isSelected = false
        
        rootView.archiveListCollectionView.snp.remakeConstraints {
            $0.top.equalTo(rootView.petCollectionView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(438)
        }
    }
    
    @objc
    private func galleryButtonDidTap() {
        rootView.archiveListCollectionView.isHidden = true
        rootView.archiveGridCollectionView.isHidden = false
        rootView.archiveBottomView.isHidden = true
        
        rootView.listButton.isSelected = false
        rootView.gridButton.isSelected = true
        
        rootView.archiveListCollectionView.snp.remakeConstraints {
            $0.top.equalTo(rootView.petCollectionView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc
    private func bottomViewDidTap() {
        deselectAllOfListArchiveCollectionViewCell()
    }
    
    
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == rootView.petCollectionView {
            return petData.count
        }
        
        if collectionView == rootView.archiveListCollectionView {
            return archiveData.count
        }
        
        if collectionView == rootView.archiveGridCollectionView {
            return archiveData.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == rootView.petCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePetCollectionViewCell.cellIdentifier,
                                                                for: indexPath) as?  HomePetCollectionViewCell else { return UICollectionViewCell() }
            
            cell.dataBind(data: petData[indexPath.item])
            return cell
        }
        
        if collectionView == rootView.archiveListCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeArchiveListCollectionViewCell.cellIdentifier,
                                                                for: indexPath) as?  HomeArchiveListCollectionViewCell else { return UICollectionViewCell() }
            
            cell.dataBind(data: archiveData[indexPath.item])
            cell.updateWriterCollectionViewCell()
            return cell
        }
        
        if collectionView == rootView.archiveGridCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeArchiveGridCollectionViewCell.cellIdentifier,
                                                                for: indexPath) as?  HomeArchiveGridCollectionViewCell else { return UICollectionViewCell() }
            
            cell.dataBind(data: archiveData[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

//MARK: - UICollectionViewDelegate

extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        if collectionView == rootView.archiveListCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeArchiveListCollectionViewCell else { return false }
            
            switch cell.viewType {
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
        if collectionView == rootView.petCollectionView {
            collectionView.performBatchUpdates(nil)
            requestTotalArchiveAPI(petID: petData[indexPath.item].id )
            
        }
        
        if collectionView == rootView.archiveListCollectionView {
            collectionView.performBatchUpdates(nil)
        }
        
        if collectionView == rootView.archiveGridCollectionView {
            let id = String(archiveData[indexPath.item].record.id)
            pushToDetailViewController(recordID: id)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath)
    {
        if collectionView == rootView.petCollectionView {
            collectionView.performBatchUpdates(nil)
        }
         
        if collectionView == rootView.archiveListCollectionView {
            collectionView.performBatchUpdates(nil)
        }
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == rootView.petCollectionView {
            switch collectionView.indexPathsForSelectedItems?.first {
            case .some(indexPath):
                guard let cell = collectionView.cellForItem(at: indexPath) as? HomePetCollectionViewCell else { return .zero}
                cell.dataBind(data: petData[indexPath.item])
                return cell.sizeFittingWith(cellHeight: 40)
            default:
                return CGSize(width: 40, height: 40)
            }
        }
        
        if collectionView == rootView.archiveListCollectionView {
            switch collectionView.indexPathsForSelectedItems?.first {
            case .some(indexPath):
                return CGSize(width: 195, height: 436)
            default:
                return CGSize(width: 60, height: 436)
            }
        }
        
        if collectionView == rootView.archiveGridCollectionView {
            return CGSize(width: 100, height: 100)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        if collectionView == rootView.petCollectionView {
            return 4
        }
        
        if collectionView == rootView.archiveListCollectionView {
            return 11
        }
        if collectionView == rootView.archiveGridCollectionView {
            return 10
        }
        
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if collectionView == rootView.petCollectionView {
            return .zero
        }
        
        if collectionView == rootView.archiveListCollectionView{
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
        
        if collectionView == rootView.archiveGridCollectionView{
            return UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 30)
        }
        
        return .zero
        
    }
}

//MARK: - ScrollViewDelegate

extension HomeViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == rootView.archiveListCollectionView{
            
            let scroll = scrollView.contentOffset.x + scrollView.contentInset.left
            let width = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
            let scrollRatio = scroll / width
            
            self.rootView.archiveIndicatorView.leftOffsetRatio = scrollRatio
        }
    }
}
