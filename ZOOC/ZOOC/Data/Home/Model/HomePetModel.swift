//
//  HomePetModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/07.
//

import UIKit

struct HomePetModel{
    let image: UIImage
    let name: String
}

extension HomePetModel{
    static var mockData : [HomePetModel] = [
                                        HomePetModel(image: Image.mockPet2, name: "포미"),
                                        HomePetModel(image: Image.mockPet1, name: "복실이"),
                                        HomePetModel(image: Image.mockPet2, name: "토리토리"),
                                        HomePetModel(image: Image.mockPet1, name: "초코")
                                            ]
}
