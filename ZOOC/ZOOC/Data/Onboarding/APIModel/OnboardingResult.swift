//
//  OnboardingResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import Foundation

import Foundation

// MARK: - MyResult
struct OnboardingResult: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: OnboardingTokenData
}

// MARK: - DataClass
struct OnboardingTokenData: Codable {
    let jwtToken: String
    
    enum CodingKeys: String, CodingKey {
        case jwtToken
    }
}
