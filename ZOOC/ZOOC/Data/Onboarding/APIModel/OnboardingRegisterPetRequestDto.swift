//
//  OnboardingRegisterPetRequestDto.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/11.
//

import Foundation


struct OnboardingRegisterPetRequestDto: Codable {
    let names: [String]
    let photos: [Data]
    
    enum CodingKeys : String, CodingKey {
        case names = "petNames"
        case photos = "petPhotos"
    }
}
