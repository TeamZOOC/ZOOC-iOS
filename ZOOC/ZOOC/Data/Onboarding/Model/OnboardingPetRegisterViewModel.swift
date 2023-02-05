//
//  OnboardingpetRegiserViewModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/01.
//

import UIKit

final class OnboardingPetRegisterViewModel {
    var addCellClosure: (() -> Void)?
    var deleteCellClosure: (() -> Void)?
    
    var petList: [OnboardingPetRegisterModel] = []
    var petCount: Int = 4
    var index: Int = 0
    var tag: Int = 0
    
    func addCell() {
        let cell: OnboardingPetRegisterModel = OnboardingPetRegisterModel(profileImage: Image.defaultProfilePet, profileName: "")
        petList.append(cell)
        petCount += 1
    }
    
    func deleteCell(index: Int) {
        petList.remove(at: index)
        petCount -= 1
    }
    
    func hideFooterView(button: inout Bool) {
        button = petList.count == 4 ? true : false
    }
    
    func hideDeleteButton(button: inout Bool) {
        button = petList.count == 1 ? true : false
    }
}

