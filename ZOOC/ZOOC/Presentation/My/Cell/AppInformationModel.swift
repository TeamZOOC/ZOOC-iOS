//
//  AppTableViewModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/03.
//

import Foundation

struct AppInformationModel {
    let appInformationName: String
}

extension AppInformationModel {
    static var appInformationModel: [AppInformationModel] = [
        AppInformationModel(appInformationName: "서비스 이용약관"),
        AppInformationModel(appInformationName: "개인정보 처리방침"),
        AppInformationModel(appInformationName: "마케팅 정보 수신 동의")
    ]
}


