//
//  HomeDetailArchiveEmojiBottomSheet.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/17.
//

import UIKit

import SnapKit
import Then

final class HomeDetailArchiveEmojiBottomSheet: UIViewController {
    
    //MARK: - Properties
    
    private lazy var dimmedTapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
    
    //MARK: - UI Components
    
    private let dimmedView = UIView()
    private let bottomSheet = UIView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    private func hierarchy() {
        view.addSubviews(dimmedView,bottomSheet)
    }
    
    private func layout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
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
        print(#function)
        dismissBottomSheet()
    }
}

