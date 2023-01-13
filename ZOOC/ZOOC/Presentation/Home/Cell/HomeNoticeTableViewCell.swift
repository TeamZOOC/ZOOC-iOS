//
//  HomeAlarmTableViewCell.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import UIKit

import SnapKit
import Then

final class HomeNoticeTableViewCell: UITableViewCell {
    
    //MARK: - UI Components
    
    public var alarmUserProfile = UIImageView().then {
        $0.layer.cornerRadius = 21
        $0.clipsToBounds = true
    }
    
    private var alarmContentLabel = UILabel().then {
        $0.textColor = .zoocDarkGray2
        $0.font = .zoocBody2
        $0.textAlignment = .left
    }
    
    private var createdTimeLabel = UILabel().then {
        $0.textColor = .zoocGray1
        $0.font = .zoocCaption
        $0.textAlignment = .left
    }
    
    private var separatorUnderLine = UIView().then {
        $0.backgroundColor = UIColor(r: 233, g: 233, b: 233)
    }
    
    //MARK: - Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.addSubviews(alarmUserProfile, alarmContentLabel, createdTimeLabel, separatorUnderLine)
        
        alarmUserProfile.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(34)
            $0.size.equalTo(42)
        }
        
        alarmContentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalTo(self.alarmUserProfile.snp.trailing).offset(16)
        }
        
        createdTimeLabel.snp.makeConstraints {
            $0.top.equalTo(self.alarmContentLabel.snp.bottom).offset(3)
            $0.leading.equalTo(self.alarmContentLabel)
        }
        
        separatorUnderLine.snp.makeConstraints {
            $0.top.equalTo(self.createdTimeLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(315)
            $0.height.equalTo(1)
        }
    }
    
    func dataBind(data: HomeNoticeResult) {
        if data.writer.photo == nil {
            alarmUserProfile.image = Image.defaultProfile
        } else {
            alarmUserProfile.kfSetImage(url: data.writer.photo!)
        }
        
        alarmContentLabel.text = "\(data.writer.nickName)님이 새로운 게시물을 올렸습니다."
        createdTimeLabel.text = data.created_time
    }
}


