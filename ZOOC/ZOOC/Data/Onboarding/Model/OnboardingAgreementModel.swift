//
//  AgreementModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

struct OnboardingAgreementModel {
    let agreementMenu: String
    var isSelected: Bool
}

extension OnboardingAgreementModel {
    static var agreementData: [OnboardingAgreementModel] = [
        OnboardingAgreementModel(agreementMenu: "ZOOC 이용약관 (필수)", isSelected: false),
        OnboardingAgreementModel(agreementMenu: "개인정보 이용약관 동의 (필수)", isSelected: false),
        OnboardingAgreementModel(agreementMenu: "마케팅 정보 수신 동의 (선택)", isSelected: false),
        OnboardingAgreementModel(agreementMenu: "만 14세 이상 확인 (필수)", isSelected: false)
    ]
}


