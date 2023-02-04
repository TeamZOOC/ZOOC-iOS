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
    }
    
    func deleteCell(index: Int) {
        petList.remove(at: index)
    }
    
    func hideFooterView(button: inout Bool) {
        print("현재의 펫 마리수는 \(petCount)")
        button = petCount == 0 ? true : false
    }
    
    func hideDeleteButton(button: inout Bool) {
        button = petList.count == 1 ? true : false
    }
}


