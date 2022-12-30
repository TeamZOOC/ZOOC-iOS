//
//  RecordViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit

import SnapKit
import Then

final class RecordViewController : BaseViewController{
    
    //MARK: - Properties
    
    private let label = UILabel().then {
        $0.font = .zoocDisplay2
        $0.text = "기록하기"
    }
    
    private lazy var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    
    private func setUI(){
        view.addSubviews(label,backButton)
        
    }
    
    private func setLayout(){
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(67)
            $0.leading.equalToSuperview().offset(31)
        }
        
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap(){
        dismiss(animated: true)
    }
}
