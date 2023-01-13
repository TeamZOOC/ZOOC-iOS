//
//  HomeAlarmModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import UIKit

struct HomeNoticeModel{
    let profileImage: UIImage
    let profileName: String
    let createdTime: String
}

extension HomeNoticeModel{
    static var mockData : [HomeNoticeModel] = [
        HomeNoticeModel(profileImage: Image.mockPet2, profileName: "포미", createdTime: "2022.11.05"),
        HomeNoticeModel(profileImage: Image.mockPet1, profileName: "복실이", createdTime: "2022.11.05"),
        HomeNoticeModel(profileImage: Image.mockPet2, profileName: "토리토리", createdTime: "2022.11.05"),
        HomeNoticeModel(profileImage: Image.mockPet1, profileName: "초코", createdTime: "2022.11.05")
    ]
}
