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
        myNoticeSettingView.backButton.addTarget(self, action: #selector(popToMyProfileView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Action Method
    
    @objc
    private func popToMyProfileView() {
        self.navigationController?.popViewController(animated: true)
    }
}
