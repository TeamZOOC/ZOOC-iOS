//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class  MyViewController : BaseViewController{
    
    //MARK: - Properties
    
    let label = UILabel().then {
        $0.font = .zoocDisplay2
        $0.text = "마이페이지"
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
