//
//  MyNoticeSettingView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/07.
//

import UIKit

import SnapKit
import Then

final class MyNoticeSettingView: UIView {
    
    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    private var noticeSettingLabel = UILabel().then {
        $0.font = .zoocHeadLine
        $0.text = "알림 설정"
        $0.textColor = .zoocDarkGray2
    }
    
    private var noticeSettingSubView = UIView().then {
        $0.backgroundColor = .zoocWhite1
    }
    
    private var postingTitleLabel = UILabel().then {
        $0.font = .zoocBody3
        $0.text = "게시물 작성"
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private var postingdescribeLabel = UILabel().then {
        $0.font = .zoocCaption
        $0.text = "우리 가족이 게시물을 쓰면 바로 알 수 있어요"
        $0.textColor = .zoocGray2
        $0.textAlignment = .left
    }
    
    private var permitNoticeSwitchButton = UISwitch()

    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout() {
        addSubviews(backButton, noticeSettingLabel, noticeSettingSubView)
        noticeSettingSubView.addSubviews(postingTitleLabel, postingdescribeLabel, permitNoticeSwitchButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        noticeSettingLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        noticeSettingSubView.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(375)
            $0.height.equalTo(91)
        }
        
        postingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(31)
        }
        
        postingdescribeLabel.snp.makeConstraints {
            $0.top.equalTo(self.postingTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.postingTitleLabel)
        }
        
        permitNoticeSwitchButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(52)
            $0.height.equalTo(32)
        }
    }
}

