//
//  RecordTotalPetResult.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/13.
//

import Foundation

struct RecordPetResult: Codable{
    let id: Int
    let name: String
    let photo: String?
}

extension RecordPetResult{
    func transform()-> RecordRegisterModel{
        RecordRegisterModel(petID: self.id,
                            petImageURL: self.photo,
                            petName: self.name,
                            isSelected: false)
    }
}
