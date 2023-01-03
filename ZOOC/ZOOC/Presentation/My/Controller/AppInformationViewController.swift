//
//  AppInformationViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class  AppInformationViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var appInformationView = AppInformationView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = appInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        
    }
    
    //MARK: - Custom Method
    
    private func register() {
//        appInformationView.
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

