//
//  MyRegisterPetResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/27.
//

import Foundation

// MARK: - OnboardingRegisterPetResult
struct MyRegisterPetResult: Codable {
    let id: Int
    let name: String
    let photo: String?
}

