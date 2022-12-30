//
//  PracticeViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit

import SnapKit
import Then

final class PracticeViewController : BaseViewController{ // UIViewContrller가 아닌 BaseViewController를 상속받아주세요.
    
    //MARK: - Properties
    
    let label = UILabel().then {
        $0.font = .zoocDisplay2
        $0.text = "연습"
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
        
    }
    
    private func setLayout(){
        view.addSubview(label)
            
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    //MARK: - Action Method
    
}
