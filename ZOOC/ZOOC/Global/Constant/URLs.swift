//
//  URL.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import Foundation

public enum URLs{
    
    //MARK: - Family
    static let getNotice = "/alarm/list"
    static let myPage = "/family/mypage"
    static let getFamily = "family/"
    static let getInviteCode = "family/code/{familyId}"
    static let registerPet = "family/pet/{familyId}"
    static let registerUser = "/familiy/user"
    
    //MARK: - User
    
    static let socialLogin = "user/kako/signin"
    static let editProfile = "/user/profile"
    static let signUp = "/user/create?code={code}"
    static let deleteUser = "/user"
    
    //MARK: - Record
    static let getMission = "/record/mission/{familyId}"
    static let totalPet = "/record/pet/{familyId}"
    static let postRecord = "/record/{familyId}"
    static let postMission = "/record/{familyId}?missionId={missionId}"
    static let detailRecord = "/record/{familyId}/{recordId}"
    static let totalRecord = "/record/{familyId}"
    static let deleteRecord = "/record/{recordId}"
    
    //MARK: - Comment
    
    static let postComment = "/comment/{recordId}"
    static let postEmojiComment = "/comment/emoji/{recordId}"
    static let deleteComment = "/record/{commentId}"
    
}
