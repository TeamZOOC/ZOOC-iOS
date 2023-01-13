//
//  OnboardingResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import Foundation

// MARK: - MyResult

struct OnboardingResult: Codable {
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Codable {
    let jwtToken: String
}

