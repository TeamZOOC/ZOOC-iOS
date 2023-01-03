//
//  SettingMenuModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/02.
//

import Foundation
import UIKit

struct SettingMenuModel {
    let settingMenuName: String
    let isLogout: Bool
}

extension SettingMenuModel {
    static var settingMenuData: [SettingMenuModel] = [
        SettingMenuModel(settingMenuName: "알림설정", isLogout: false),
        SettingMenuModel(settingMenuName: "공지사항", isLogout: false),
        SettingMenuModel(settingMenuName: "문의하기", isLogout: false),
        SettingMenuModel(settingMenuName: "미션 제안하기", isLogout: false),
        SettingMenuModel(settingMenuName: "앱 정보", isLogout: false),
        SettingMenuModel(settingMenuName: "로그아웃", isLogout: true)
    ]
} 

