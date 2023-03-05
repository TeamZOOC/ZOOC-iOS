//
//  OnboardingRegisterUserResult.swift
//  ZOOC
//
//  Created by 장석우 on 2023/03/05.
//

import Foundation

struct OnboardingJoinFamilyResult: Codable {
    let userID: Int
    let familyID: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case familyID = "family_id"
    }
    
}


