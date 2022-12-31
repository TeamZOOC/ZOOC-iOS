//
//  URL.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

public enum URLs{
    
    //MARK: - Family
    static let myPage = "/familiy"
    static let invite = "/familiy/invite"
    static let registerPet = "/familiy/pet"
    static let createFamiliy = "/familiy/"
    static let registerUser = "/familiy/user"
    
    //MARK: - User
    static let signUp = "/user/signup"
    static let postPushUser = "/user/push"
    static let signIn = "/user/signin"
    static let editProfile = "/user/profile"
    
    //MARK: - Record
    static let mission = "/record/mission"
    static let totalPet = "/record/pet"
    static let postRecord = "/record/"
    static let detailRecord = "/record/{recordId}"
    static let totalRecord = "/record/"
    static let deleteRecord = "/record/{recordId}"
    
    //MARK: - Mission
    static let postComment = "/record/{commentId}"
    static let deleteCommen = "/record/{commentId}"
    
}
