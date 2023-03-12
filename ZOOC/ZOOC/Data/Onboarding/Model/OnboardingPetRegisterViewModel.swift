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
    var uploadCellClosure: (() -> Void)?
    
    var petList: [OnboardingPetRegisterModel] = []
    var petCount: Int = 4
    var index: Int = 0
    var tag: Int = 0
    
    func addCell() {
        let cell: OnboardingPetRegisterModel = OnboardingPetRegisterModel(image: Image.cameraCircle, name: "")
        petList.append(cell)
        petCount += 1
    }
    
    func deleteCell(index: Int) {
        petList.remove(at: index)
        petCount -= 1
    }
    
    func uploadImage(index: Int, image: UIImage) {
        petList[index].image = image
    }
    
    func hideFooterView(button: inout Bool) {
        button = petList.count == 4 ? true : false
    }
    
    func hideDeleteButton(button: inout Bool) {
        button = petList.count == 1 ? true : false
    }
    
    func checkCanRegister(button: inout Bool, color: inout UIColor?) {
        button = true
        color = .zoocGradientGreen
        print("추가할 수 있어요! \(button)")
        for pet in petList {
            if pet.name.count == 0 {
                button = false
                color = .zoocGray1
                print("\(pet.name) 때문에 추가할 수 없어요! \(button)")
                break
            }
        }
    }
}

