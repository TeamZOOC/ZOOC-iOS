 //
 //  memberModel.swift
 //  ZOOC
 //
 //  Created by 류희재 on 2023/01/02.
 //

import UIKit

 struct MemberModel {
     let memberProfileImage: UIImage
     let memberProfileName: String
 }

 extension MemberModel {
     static var familyDummyData: [MemberModel] = [
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfile, memberProfileName: "복실이")
     ]

     static var petDummyData: [MemberModel] = [
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이"),
         MemberModel(memberProfileImage: Image.defaultProfilePet, memberProfileName: "복실이")
     ]
 }
