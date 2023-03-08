//
//  HomeGuideView.swift
//  ZOOC
//
//  Created by 장석우 on 2023/03/08.
//

import UIKit

import SnapKit
import Then

final class HomeGuideView : UIView{
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private let backgroundView = UIView()
    private let graphicsImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let arrowImageView = UIImageView()
    
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
        
        backgroundView.do {
            $0.backgroundColor = .zoocDarkGray1
        }
        
        graphicsImageView.do {
            $0.image = Image.graphics8
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.text = "가족의 첫 추억을 남겨볼까요?"
            $0.textColor = .zoocWhite1
            $0.font = .zoocHeadLine
        }
        
        subTitleLabel.do {
            $0.text = "아래 버튼을 눌러 시작해보세요"
            $0.textColor = .zoocGray1
            $0.font = .zoocBody3
        }
        
        arrowImageView.do {
            $0.image = Image.arrowDown
            $0.contentMode = .scaleAspectFit
        }
    }
   
    
    private func hierarchy() {
        self.addSubview(backgroundView)
        
        self.addSubviews(graphicsImageView,
                         titleLabel,
                         subTitleLabel,
                         arrowImageView)
    }
    
    private func layout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        graphicsImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top).offset(-18)
            $0.size.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-130)
        }
    }
}
