//
//  HomeDetailArchiveViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class HomeDetailArchiveViewController : BaseViewController{
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private lazy var dismissButton : UIButton = {
        let button  = UIButton()
        button.setImage(Image.back, for: .normal)
        button.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    //MARK: - Custom Method
    
    
    private func setUI(){
        view.backgroundColor = .systemPink
        hidesBottomBarWhenPushed = true
    }
    
    private func setLayout(){
        view.addSubview(dismissButton)
        
        dismissButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    //MARK: - Action Method
    @objc func dismissButtonDidTap(){
        dismiss(animated: true)
    }
}
