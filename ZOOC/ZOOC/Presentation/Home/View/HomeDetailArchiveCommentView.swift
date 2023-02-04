//
//  HomeDetailArchiveCommentView.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/04.
//

import UIKit

import SnapKit
import Then


final class HomeDetailArchiveCommentView : UIView {
    
    //MARK: - Properties
    
    private var text : String?
    
    //MARK: - UI Components
    private let lineView = UIView()
    private let commentTextField = HomeDetailArchiveCommentTextField()
    private let commentEmojiButton = UIButton()
    private let hStackView = UIStackView()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        target()
        
        style()
        hierarchy()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func register() {
        commentTextField.commentDelegate = self
    }
    
    private func target() {
        commentEmojiButton.addTarget(self,
                                     action: #selector(emojiButtonDidTap),
                                     for: .touchUpInside)
    }
    
    private func style() {
        
        self.backgroundColor = .zoocBackgroundGreen
        
        lineView.do {
            $0.backgroundColor = .zoocLightGray
        }
        commentTextField.do {
            $0.inputAccessoryView = self
        }
        
        commentEmojiButton.do {
            $0.setImage(Image.smile, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        hStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
            $0.spacing = 7
            
        }
    }
    
    private func hierarchy() {
        
        self.addSubviews(lineView,hStackView)
        
        hStackView.addArrangedSubViews(commentTextField,commentEmojiButton)
    }
    
    private func layout() {
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        commentEmojiButton.snp.makeConstraints {
            $0.size.equalTo(30)
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(47)
        }
        
        
        
    }
    
    //MARK: - Action Method
    
    @objc
    private func emojiButtonDidTap() {
        print(#function)
    }
    
    
}

extension HomeDetailArchiveCommentView: CommentTextFieldDelegate{
    
    func commentTextFieldDidUplaod(_ textfield: HomeDetailArchiveCommentTextField,
                                   text: String) {
        print("asdfasdf")
        textfield.endEditing(true)
        
    }
    
    
}
