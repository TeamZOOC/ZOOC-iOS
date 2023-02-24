//
//  HomeDetailArchiveEmojiBottomSheet.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/17.
//

import UIKit

import SnapKit
import Then

protocol EmojiBottomSheetDelegate: AnyObject{
    func emojiDidSelected(tag: Int)
}


final class EmojiBottomSheetViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: EmojiBottomSheetDelegate?
    private let emojiData = EmojiModel.data
    private lazy var dimmedTapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
    
    //MARK: - UI Components
    
    private let dimmedView = UIView()
    private let bottomSheet = UIView()
    private let emojiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        gesture()
        style()
        hierarchy()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentBottomSheet()
    }
    
    //MARK: - Custom Method
    
    private func register() {
        emojiCollectionView.delegate = self
        emojiCollectionView.dataSource = self
        
        emojiCollectionView.register(EmojiCollectionViewCell.self,
                                     forCellWithReuseIdentifier: EmojiCollectionViewCell.cellIdentifier)
        
    }
    
    private func gesture() {
        dimmedView.addGestureRecognizer(dimmedTapGesture)
    }
    
    private func style() {
        dimmedView.do{
            $0.backgroundColor = .black
            $0.alpha = 0
            $0.isUserInteractionEnabled = true
        }
        
        bottomSheet.do{
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.clipsToBounds = true
        }
        
        emojiCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    }
    
    private func hierarchy() {
        view.addSubviews(dimmedView,bottomSheet)
        bottomSheet.addSubview(emojiCollectionView)
    }
    
    private func layout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        emojiCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-45)
        }
    }
    
    private func presentStyle() {
        dimmedView.alpha = 0.2
        bottomSheet.snp.updateConstraints {
            $0.top.equalTo(view.snp.bottom).offset(-261)
        }
    }
    
    private func dismissStyle() {
        dimmedView.alpha = 0
        bottomSheet.snp.updateConstraints {
            $0.top.equalTo(view.snp.bottom)
        }
    }
    
    private func presentBottomSheet() {
        UIView.animate(withDuration: 0.25) {
            self.presentStyle()
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissBottomSheet() {
        UIView.animate(withDuration: 0.25, animations: {
            self.dismissStyle()
            self.view.layoutIfNeeded()
        }) {_ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    private func dimmedViewTapped() {
        dismissBottomSheet()
    }
}

extension EmojiBottomSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                EmojiCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? EmojiCollectionViewCell else { return UICollectionViewCell()}
        cell.dataBind(data: emojiData[indexPath.item])
        return cell
    }
}

extension EmojiBottomSheetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EmojiCollectionViewCell else { return }
        guard let tag = cell.emojiData?.tag else { return }
        delegate?.emojiDidSelected(tag: tag)
        dismissBottomSheet()
    }
}

extension EmojiBottomSheetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
