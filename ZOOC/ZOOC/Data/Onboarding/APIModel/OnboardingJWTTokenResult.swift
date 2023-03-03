//
//  OnboardingResult.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import Foundation

// MARK: - MyResult

struct OnboardingJWTTokenResult: Codable {
    let jwtToken: String
    let isExistedUser: Bool
}
