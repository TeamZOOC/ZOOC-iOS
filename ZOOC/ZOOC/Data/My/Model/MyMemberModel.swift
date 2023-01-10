 //
 //  memberModel.swift
 //  ZOOC
 //
 //  Created by 류희재 on 2023/01/02.
 //

import UIKit

 struct MyMemberModel {
     let profileImage: UIImage
     let profileName: String
 }

 extension MyMemberModel {
     static var familyDummyData: [MyMemberModel] = [
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfile, profileName: "복실이")
     ]

     static var petDummyData: [MyMemberModel] = [
         MyMemberModel(profileImage: Image.defaultProfilePet, profileName: "복실이"),
         MyMemberModel(profileImage: Image.defaultProfilePet, profileName: "복실이")
     ]
 }
