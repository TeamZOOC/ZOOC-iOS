//
//  HomeIndicatorView.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/08.
//

import UIKit

import SnapKit
import Then

final class HomeArchiveProgressView : UIView{
    
    //MARK: - Properties
    
    private var leftInsetConstraint: Constraint?
    
    var leftOffsetRatio: Double? {
      didSet {
        guard let leftOffsetRatio = self.leftOffsetRatio else { return }
        self.leftInsetConstraint?.update(inset: leftOffsetRatio * self.bounds.width)
      }
    }
    
    var widthRatio: Double? {
      didSet {
        guard let widthRatio = self.widthRatio else { return }
        self.progressTintView.snp.remakeConstraints {
          $0.top.bottom.equalToSuperview()
          $0.width.equalToSuperview().multipliedBy(widthRatio)
          $0.left.greaterThanOrEqualToSuperview()
          $0.right.lessThanOrEqualToSuperview()
          self.leftInsetConstraint = $0.left.equalToSuperview().priority(900).constraint
        }
      }
    }

    
    //MARK: - UI Components
    
    private let progressView = UIView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .zoocLightGreen
    }
    
    private let progressTintView = UIView().then {
        $0.backgroundColor = .zoocDarkGreen
    }
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        
    }
    
    private func setLayout(){
        self.addSubview(progressView)
        progressView.addSubview(progressTintView)
        
        progressView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressTintView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(1/6)
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
            leftInsetConstraint = $0.left.equalToSuperview().priority(900).constraint
        }
    }
    
    //MARK: - Action Method
    
}
