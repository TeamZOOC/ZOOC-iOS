//
//  HomeRecordModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/05.
//


import UIKit

struct HomeArchiveModel{
    let petImage : UIImage
    let writerName : String
    let writerImage : UIImage
    let content : String
    let profileImage : UIImage
    let date: String
}

extension HomeArchiveModel{
    static let mockData : [HomeArchiveModel] = [
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마마마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마마마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마마마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마마마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5"),
                                        HomeArchiveModel(petImage: Image.mockPet1,
                                                        writerName: "엄마",
                                                        writerImage: Image.defaultProfile,
                                                        content: "너무너무너무너ㄴ무너무너무 귀업당다앋ㅇ당당당당다아다아다",
                                                        profileImage: Image.defaultProfile,
                                                        date: "1/5")
                                        
                                        
                                        
    
    
    
    ]
}
