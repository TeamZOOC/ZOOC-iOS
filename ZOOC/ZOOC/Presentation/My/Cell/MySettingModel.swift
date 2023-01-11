//
//  SettingMenuModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import Foundation

struct MySettingModel {
    let title: String
    let isLogout: Bool
}

extension MySettingModel {
    static var settingData: [MySettingModel] = [
        MySettingModel(title: "알림설정", isLogout: false),
        MySettingModel(title: "공지사항", isLogout: false),
        MySettingModel(title: "문의하기", isLogout: false),
        MySettingModel(title: "미션 제안하기", isLogout: false),
        MySettingModel(title: "앱 정보", isLogout: false),
        MySettingModel(title: "로그아웃", isLogout: true)
    ]
} 

