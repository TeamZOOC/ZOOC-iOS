//
//  BaseViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

class BaseViewController : UIViewController{
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        view.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout(){
        
    }
    
    //MARK: - Action Method
    
}
