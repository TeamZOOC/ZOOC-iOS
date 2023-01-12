//
//  HomeAlarmView.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/13.
//

import UIKit

import SnapKit
import Then

final class HomeNoticeView: UIView {
    
    //MARK: - UI Components
    
    public var backButton = UIButton().then {
        $0.setImage(Image.back, for: .normal)
    }
    
    public var alarmTitleLabel = UILabel().then {
        $0.text = "알림"
        $0.textColor = .zoocDarkGray1
        $0.textAlignment = .left
        $0.font = .zoocHeadLine
    }
    
    public var noticeTableView = UITableView(frame: .zero, style: .plain).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.backgroundColor = .zoocBackgroundGreen
    }
    
    
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
        addSubviews(backButton, alarmTitleLabel, noticeTableView)
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.leading.equalToSuperview().offset(17)
            $0.size.equalTo(42)
        }
        
        alarmTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self.backButton.snp.trailing)
        }
        
        noticeTableView.snp.makeConstraints {
            $0.top.equalTo(self.alarmTitleLabel.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
}
    
    
