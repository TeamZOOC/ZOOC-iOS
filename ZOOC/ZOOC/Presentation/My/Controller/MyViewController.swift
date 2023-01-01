//
//  MyViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

final class  MyViewController: BaseViewController{
    
    //MARK: - Properties
    
    private lazy var myView = MyView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
    }
        
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        
    }
    
    //MARK: - Custom Method
    
    private func register() {
        myView.register(MemberCollectionView.self, forCellReuseIdentifier: MemberCollectionView.identifier)
    }
    
    //MARK: - Action Method
    
}

extension MyViewController: UITableViewDelegate {}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
