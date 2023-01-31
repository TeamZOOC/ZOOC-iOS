//
//  OnboardingPetRegisterModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/09.
//

import UIKit

struct OnboardingPetRegisterModel {
    var profileImage: UIImage
    var profileName: String
}

final class OnboardingpetRegiserViewModel {
    var addCellClosure: (() -> Void)?
    var deleteCellClosure: (() -> Void)?
    
    var petList: Helper<[OnboardingPetRegisterModel]> = Helper([])
    var petCount: Helper<Int> = Helper(4)
    var index: Helper<Int> = Helper(0)
    var tag: Helper<Int> = Helper(0)
    
    var addButtonState: Helper<Bool> = Helper(false)
    
    func addCell() {
        let cell: OnboardingPetRegisterModel = OnboardingPetRegisterModel(profileImage: Image.defaultProfilePet, profileName: "헬로")
        petList.value.append(cell)
        addButtonState.value = false
        petCount.value -= 1
    }
    
    func deleteCell(index: Int) {
        petList.value.remove(at: index)
        petCount.value += 1
    }
}





import Foundation

class Helper<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
