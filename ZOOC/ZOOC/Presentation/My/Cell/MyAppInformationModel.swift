//
//  AppTableViewModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/03.
//

import Foundation

struct MyAppInformationModel {
    let title: String
}

extension MyAppInformationModel {
    static var appInformationData: [MyAppInformationModel] = [
        MyAppInformationModel(title: "서비스 이용약관"),
        MyAppInformationModel(title: "개인정보 처리방침"),
        MyAppInformationModel(title: "마케팅 정보 수신 동의")
    ]
}


