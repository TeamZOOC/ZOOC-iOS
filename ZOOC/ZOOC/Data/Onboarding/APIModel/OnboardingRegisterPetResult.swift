//
//  OnboardingRegisterResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/11.
//

import Foundation

// MARK: - OnboardingRegisterPetResult
struct OnboardingRegisterPetResult: Codable {
    let data: [OnboardingPetData]
}

// MARK: - Datum
struct OnboardingPetData: Codable {
    let id: Int
    let name: String
    let photo: String
}
