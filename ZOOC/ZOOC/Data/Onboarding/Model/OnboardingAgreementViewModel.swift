//
//  OnboardingAgreementViewModel.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/22.
//

import UIKit

final class OnboardingAgreementViewModel {
    
    var updateAgreementClosure: (() -> Void)?
    var updateAllAgreementClosure: (() -> Void)?
    
    // 1. 동의항목 bool타입 배열 프로퍼티
    var agreementList: [OnboardingAgreementModel] = OnboardingAgreementModel.agreementData
    
    // 2. 눌린 버튼이 무엇인지 식별할 수 있는 index int 타입 프로퍼티
    var index: Int = 0
    
    // 3. 전체 동의 버튼의 상태를 알려주는 bool 타입 프로퍼티
    var allAgreement: Bool = false
    
    //  1. 각 동의 항목의 상태 변환 메소드
    
    func updateAgreementState(index: Int /*button: inout UIButton?*/) {
        agreementList[index].isSelected = agreementList[index].isSelected == true ? false : true
        print(agreementList[index])
//        let image = agreementList[index] ? Image.checkBoxFill : Image.checkBox
//        button!.setImage(image, for: .normal)
    }
    
    //  2. 전체동의 버튼을 눌렀을 때 실행되는 메소드
    func updateAllAgreementState() {
        allAgreement = allAgreement == true ? false : true
    }
    
    // 3. 동의 항목 상태에 따른 전체동의 버튼 상태 변화 메소드
    func updateAllAgreementButtonTapped() {
        for index in 0..<agreementList.count {
            agreementList[index].isSelected = allAgreement
        }
    }
    
    // 4. 다음 버튼 활성화 메소드
    func updateNextButton(button: inout Bool, color: inout UIColor) {
        if (agreementList[0].isSelected && agreementList[1].isSelected && agreementList[3].isSelected == true) {
            button = true
            color = .zoocGradientGreen
        } else {
            button = false
            color = .zoocGray1
        }
    }
    
//    // 동의 항목 버튼 이미지 변화
//    func updateCheckBoxButton(index: Int, image: inout UIImage?) {
//        image = agreementList[index] ? Image.checkBoxFill : Image.checkBox
//    }
}


/* 여기서 관리하고 싶은거
1. 각 항목의 상태변화 (false -> true, true -> false)
2. 이를 통해서 전체항목 선택 버튼의 상태 변화
3. 전체동의 버튼을 눌럿을 때 전부 상태 true or false로 변환
3. 1,3,4번 이상 체크 했을때 다음 버튼 활성화
 
그러면 해야될 플로우 정리
 - 동의버튼 체크했을 경우
 1. 버튼을 누르면 몇번째가 눌렀는지 확인
 2. 그 동의버튼 index의 상태를 리스트에 저장되어 있는것과 반대로 지정해준다.
 
 - 전체 동의 버튼 눌렀을 때
 1. 1,2,3,4가 전부 true 일때 -> 전체동의 버튼 활성화
 2. 전체 동의 버튼을 눌렀을 때 -> 현재 상태와 반대로 바꿔주고 그에 따른 동의항목 리스트 전부 변환
 
 - 다음 버튼 활성화
 1. 1,3,4번 이상이 동의상태면 다음 버튼 활성화
 
 
 
 그러면 필요한 프로퍼티
  -> var agreementList: [OnboardingAgreementModel] = []
 2. 눌린 버튼이 무엇인지 식별할 수 있는 index int 타입 프로퍼티 -> var index: Int
 3. 전체 동의 버튼의 상태를 알려주는 bool 타입 프로퍼티 -> var allAgreement: Bool
 
 필요한 메소드
-> func updateAgreementState(index: Int)
 2. 전체동의 버튼을 눌렀을 때 실행되는 메소드 ->
  -> func updateAllAgreementState()
  -> func updateNextButton()
 */
