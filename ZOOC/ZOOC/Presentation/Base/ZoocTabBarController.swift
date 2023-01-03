//
//  ZoocTabBarController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

class ZoocTabBarController: UITabBarController {

    //MARK: - Properties
    
    let homeViewContrller = HomeViewController()
    let myViewController = MyViewController()
    
    //MARK: - UI Components
    
    private lazy var plusButton = UIButton().then {
        $0.backgroundColor = .zoocMainGreen
        $0.setImage(Image.plus, for: .normal)
        $0.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setViewController()
        setCornerRadius()
        selectedIndex = 0
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.frame.size.height = 96
        tabBar.frame.origin.y = view.frame.height - 96
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        tabBar.backgroundColor = .zoocWhite1
        tabBar.tintColor = .black
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 130
    }
    
    private func setLayout(){
        tabBar.addSubview(plusButton)
        
        plusButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(tabBar.snp.top).offset(17)
            $0.width.height.equalTo(60)
        }
    }
    
    private func setCornerRadius(){
        plusButton.layer.cornerRadius = 30
        tabBar.layer.cornerRadius = 24
        tabBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private func setViewController(){
        
        homeViewContrller.tabBarItem = UITabBarItem(title: nil,
                                                    image: Image.home,
                                                    selectedImage: Image.home)
        
        myViewController.tabBarItem = UITabBarItem(title: nil,
                                                   image: Image.person,
                                                   selectedImage: Image.person)
        
        viewControllers = [homeViewContrller,myViewController]
    }
    
    //MARK: - Action Method
    
    @objc func plusButtonDidTap(){
        let recordViewController = RecordViewController()
        recordViewController.modalPresentationStyle = .fullScreen
        present(recordViewController, animated: true)
    }

}


