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
    
    private let profileView = ProfileView()
    
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
        view.addSubview(profileView)
            
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(205)
        }
    }
    
    //MARK: - Action Method
    
}
