//
//  OnboardingRegisterResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/11.
//

import Foundation

// MARK: - Empty
struct OnboardingRegisterPetResult: Codable {
    let pet: [OnboardingPet]
}

// MARK: - Datum
struct OnboardingPet: Codable {
    let id: Int
    let name: String
    let photo: String?
}
