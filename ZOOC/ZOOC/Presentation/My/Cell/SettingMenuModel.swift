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
}

var settingMenuDummyData: [SettingMenuModel] = [
    SettingMenuModel(settingMenuName: "알림설정"),
    SettingMenuModel(settingMenuName: "공지사항"),
    SettingMenuModel(settingMenuName: "문의하기"),
    SettingMenuModel(settingMenuName: "미션 제안하기"),
    SettingMenuModel(settingMenuName: "앱 정보"),
    SettingMenuModel(settingMenuName: "로그아웃")
]
