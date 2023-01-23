//
//  MyNoticeSettingViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class MyNoticeSettingViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var myNoticeSettingView = MyNoticeSettingView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = myNoticeSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        myNoticeSettingView.backButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
}
