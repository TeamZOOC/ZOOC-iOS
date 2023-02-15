//
//  HomeDetailArchiveCommentView.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/04.
//

import UIKit

import SnapKit
import Then

protocol HomeCommentViewDelegate: UITextFieldDelegate{
    func uploadButtonDidTap()
    func emojiButtonDidTap()
}


final class HomeDetailArchiveCommentView : UIView {
    
    //MARK: - Properties
    
    private var text : String?
    weak var delegate: HomeCommentViewDelegate? 
    
    //MARK: - UI Components
    private let lineView = UIView()
    private let commentTextField = UITextField()
    private let commentEmojiButton = UIButton()
    private let hStackView = UIStackView()
    private let uploadButton = UIButton()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commentTextField.makeCornerRadius(ratio: 2)
    }
    
    //MARK: - Custom Method
    
    private func register() {
        commentTextField.delegate = self
    }
    
    private func target() {
        
        uploadButton.addTarget(self,
                         action: #selector(uploadButtonDidTap),
                         for: .touchUpInside)
        
        commentEmojiButton.addTarget(self,
                                     action: #selector(emojiButtonDidTap),
                                     for: .touchUpInside)
        
    }
    
    private func style() {
        
        self.backgroundColor = .blue
        
        lineView.do {
            $0.backgroundColor = .zoocLightGray
        }
        
        commentTextField.do {
            $0.backgroundColor = .white
            $0.layer.borderColor = UIColor.zoocGray1.cgColor
            $0.layer.borderWidth = 1
            $0.layer.masksToBounds = true
            $0.placeholder = "댓글을 입력해보세요"
            //$0.layer.cornerRadius = 26
            $0.addLeftPadding(leftInset: 24)
        }
        
        uploadButton.do {
            $0.setImage(Image.upload, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        commentEmojiButton.do {
            $0.setImage(Image.smile, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
        
        hStackView.do {
            $0.backgroundColor = .systemPink
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 7
            
        }
    }
    
    private func hierarchy() {
        
        self.addSubviews(lineView,hStackView)
        
        hStackView.addArrangedSubViews(commentTextField,
                                       commentEmojiButton)
    }
    
    private func layout() {
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        commentEmojiButton.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        hStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(47)
        }
        
    }
    
    //MARK: - Action Method
    
    @objc
    private func uploadButtonDidTap() {
        delegate?.uploadButtonDidTap()
        
    }
    
    @objc
    private func emojiButtonDidTap() {
        print(#function)
    }
   
    
    
    
}

extension HomeDetailArchiveCommentView: UITextFieldDelegate{
    
}
