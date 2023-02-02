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
    var petCount: Int = 4
    var index: Int = 0
    var tag: Int = 0
    
    func addCell() {
        let cell: MyPetRegisterModel = MyPetRegisterModel(profileName: "", profileImage: Image.defaultProfilePet)
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


