//
//  OnboardingInviteFamilyViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/10.
//

import UIKit

import SnapKit
import Then

final class OnboardingInviteFamilyViewController: BaseViewController {
    
    //MARK: - Properties
    
    private var invitedCode: String = "우르르롺끼"
    
//    private let invitedMessage: String = """
//    [ZOOC]
//
//    보미님이 ‘ZOOC’에 우리 가족을 초대하고 있어요!
//    지금 바로 아래 초대 코드를 입력하고 가족과 추억을 공유하세요!
//
//    초대코드 : SEF33210123
//
//
//
//    ▶ 아직 ZOOC을 설치하지 않으셨나요?
//
//    안드로이드 플레이스토어
//    https://play.google.com/store/apps/details?id=org.sopt.zooczoocbbangbbang
//
//    iOS 앱스토어
//    https://play.google.com/store/apps/details?id=org.sopt.zooczoocbbangbbang"
//    """
    
    private let onboardingInviteFamilyView = OnboardingInviteFamilyView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = onboardingInviteFamilyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        onboardingInviteFamilyView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        onboardingInviteFamilyView.inviteButton.addTarget(self, action: #selector(inviteButtonDidTap), for: .touchUpInside)
        onboardingInviteFamilyView.inviteLatelyButton.addTarget(self, action: #selector(inviteLatelyButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - Action Method
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func inviteLatelyButtonDidTap() {
        pushToMyInviteFamilyCompletdView()
    }
    
    @objc private func inviteButtonDidTap() {
        getInviteCode()
      
    }
}

private extension OnboardingInviteFamilyViewController {
    func pushToMyReInviteCompletdView() {
        let onboardingReInviteFamilyViewController = OnboardingReInviteFamilyViewController()
        self.navigationController?.pushViewController(onboardingReInviteFamilyViewController, animated: false)
    }
    
    func pushToMyInviteFamilyCompletdView() {
        let onboardingInviteFamilyCompletedViewController = OnboardingInviteFamilyCompletedViewController()
        self.navigationController?.pushViewController(onboardingInviteFamilyCompletedViewController, animated: true)
    }
    
    func shareInviteCode() {
        var objectToShare = [String]()
        
        objectToShare.append(invitedCode)
        
        let activityViewController = UIActivityViewController(activityItems : objectToShare, applicationActivities: nil)

        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            success ? self.pushToMyReInviteCompletdView() : print("링크 공유에 실패했습니다.")
        }
    }
    
    func getInviteCode() {
        OnboardingAPI.shared.getInviteCode(familyID: User.familyID) { result in
            guard let result = self.validateResult(result) as? OnboardingInviteResult else { return }
            let code = result.code
            self.invitedCode = code
            self.shareInviteCode()
        }
    }
}
