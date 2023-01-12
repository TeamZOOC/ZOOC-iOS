//
//  HomeAlarmViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

//
//  OnboardingInviteCompletedFamilyViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

final class HomeNoticeViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let homeNoticeView = HomeNoticeView()
    
    private var homeNoticeData: [HomeNoticeResult] = []
//    private var myFamilyMemberData: [MyUser] = []
//    private var myPetMemberData: [MyPet] = []
//    private var myProfileData: MyUser?
    
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = homeNoticeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        HomeAPI.shared.getNotice() { result in
            guard let result = self.validateResult(result) as? [HomeNoticeResult] else { return }
            self.homeNoticeData = result
            self.homeNoticeView.noticeTableView.reloadData()
        }
    }
    
    //MARK: - Custom Method
    
    func register() {
        homeNoticeView.noticeTableView.delegate = self
        homeNoticeView.noticeTableView.dataSource = self
        homeNoticeView.noticeTableView.register(HomeNoticeTableViewCell.self, forCellReuseIdentifier: HomeNoticeTableViewCell.cellIdentifier)
        
        homeNoticeView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc
    private func backButtonDidTap() {
        self.dismiss(animated: true)
    }
}

extension HomeNoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

extension HomeNoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeNoticeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeNoticeTableViewCell.cellIdentifier, for: indexPath)
                as? HomeNoticeTableViewCell else { return UITableViewCell()}
        cell.dataBind(data: homeNoticeData[indexPath.row])
        return cell
    }
}






