//
//  HomeDetailArchiveCommentView.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/11.
//

import UIKit
import SnapKit

protocol CommentTextFieldDelegate: UITextFieldDelegate{
    
    func commentTextFieldDidUplaod(_ textfield: HomeDetailArchiveCommentTextField,
                                   text: String
                                    )
}

final class HomeDetailArchiveCommentTextField: UITextField{
    
    //MARK: - Properties
    
    weak var commentDelegate: CommentTextFieldDelegate?
    
    //MARK: - UI Components
    
    private lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.upload, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self,
                         action: #selector(uploadButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    //MARK: - Custom Method
    
    private func setUI() {
        self.placeholder = "댓글을 입력해보세요"
        self.backgroundColor = .zoocWhite2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.addLeftPadding(inset: 24)
        self.isUserInteractionEnabled = true
    }
    
    private func setLayout() {
        self.addSubview(uploadButton)
        
        self.snp.makeConstraints {
            $0.height.equalTo(47)
        }
        
        uploadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-14)
            $0.width.height.equalTo(30)
        } 
    }
    
    private func validateText(_ text: String?) -> String {
        print("1 ----- \(text) -----")
        guard let text = text else { return "nil값 입니다."}
        print("2 ----- \(text) -----")
        if text.isEmpty{
            print("3 ----- \(text) -----")
        } else {
            commentDelegate?.commentTextFieldDidUplaod(self, text: text)
            print("4 ----- \(text) -----")
        }
        return text
        
    }
    
    //MARK: - Action Method
    
    @objc
    private func uploadButtonDidTap() {
        print(#function)
        
    }
}
