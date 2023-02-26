//
//  MyRegisterPetRequestDto.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/27.
//

import Foundation

struct MyRegisterPetRequestDto: Codable {
    let petNames: [String]
    let files: [Data?]
    let isPetPhotos: [Bool]
    
//    enum CodingKeys: String, CodingKey {
//        case names = "petNames"
//        case photos = "files"
//    }
}
