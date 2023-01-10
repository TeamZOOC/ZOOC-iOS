//
//  HomeDetailArchiveModel.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/10.
//

import UIKit

struct HomeDetailArchiveModel{
    var petImage: UIImage
    var date: String
    var writerImage: UIImage
    var writerName: String
    var content: String
    var comments: [ArchiveCommentModel]
}

struct ArchiveCommentModel{
    var writerImage: UIImage
    var writerName: String
    var comment: String
    var date: String
}

extension HomeDetailArchiveModel{
    
    static let mockCommentsData : [ArchiveCommentModel] = [
        ArchiveCommentModel(writerImage: Image.mockSeokWoo,
                            writerName: "장석우",
                            comment: "우와아아아 너무 귀엽따",
                            date: "1월 11일"),
        ArchiveCommentModel(writerImage: Image.mockSeokWoo,
                            writerName: "장석우",
                            comment: "우와아아아 너무 귀엽따",
                            date: "1월 11일"),
        ArchiveCommentModel(writerImage: Image.mockSeokWoo,
                            writerName: "장석우",
                            comment: "우와아아아 너무 귀엽따",
                            date: "1월 11일"),
        ArchiveCommentModel(writerImage: Image.mockSeokWoo,
                            writerName: "장석우",
                            comment: "우와아아아 너무 귀엽따",
                            date: "1월 11일"),
        ArchiveCommentModel(writerImage: Image.mockSeokWoo,
                            writerName: "장석우",
                            comment: "우와아아아 너무 귀엽따",
                            date: "1월 11일")
                            ]
    
    static let mockData : HomeDetailArchiveModel =
    HomeDetailArchiveModel(petImage: Image.mockPet1,
                           date: "1월 10일",
                           writerImage: Image.mockPet2,
                           writerName: "엄마",
                           content: "너무너무너무너무 귀엽고 예쁘지ㅣ얘들아",
                           comments: mockCommentsData)
    
}

