//
//  MyPetRegisterViewModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/02.
//

import UIKit

final class MyPetRegisterViewModel {
    var addCellClosure: (() -> Void)?
    var deleteCellClosure: (() -> Void)?
    
    var petList: [MyPetRegisterModel] = []
    var petCount: Int = 0
    var index: Int = 0
    var tag: Int = 0
    
    func addCell() {
        let cell: MyPetRegisterModel = MyPetRegisterModel(name: "", image: Image.cameraCircle)
        petList.append(cell)
        petCount += 1
    }
    
    func deleteCell(index: Int) {
        petList.remove(at: index)
        petCount -= 1
    }
    
    func hideFooterView(button: inout Bool) {
        button = petCount == 4 ? true : false
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
