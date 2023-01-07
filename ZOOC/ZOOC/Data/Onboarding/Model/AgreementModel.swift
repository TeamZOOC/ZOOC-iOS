//
//  AgreementModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

struct AgreementModel {
    let agreementMenu: String
    let checked: UIImage
}

extension AgreementModel {
    static var agreementData: [AgreementModel] = [
        AgreementModel(agreementMenu: "ZOOC 이용약관 (필수)", checked: Image.checkBox),
        AgreementModel(agreementMenu: "개인정보 이용약관 동의 (필수)", checked: Image.checkBox),
        AgreementModel(agreementMenu: "마케팅 정보 수신 동의 (선택)", checked: Image.checkBox),
        AgreementModel(agreementMenu: "만 14세 이상 확인 (필수)", checked: Image.checkBox)
    ]
}


