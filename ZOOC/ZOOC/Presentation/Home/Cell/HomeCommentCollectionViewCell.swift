//
//  HomeCommentCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/10.
//

import UIKit

import SnapKit

final class HomeCommentCollectionViewCell: UICollectionViewCell{
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private let writerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 19
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let writerLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocCaption
        label.textColor = .zoocGray2
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocBody1
        label.textColor = .zoocDarkGray2
        return label
    }()
    
    private let commentEmojiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocSmallCaption
        label.textColor = .zoocGray1
        return label
    }()
    
    private let etcButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.etc, for: .normal)
        button.contentMode = .scaleAspectFit
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    //MARK: - Custom Method
    
    private func setUI(){
        commentLabel.isHidden = false
        commentEmojiImageView.isHidden = true
    }
    
    private func setLayout(){
        contentView.addSubviews(writerImageView,
                                writerLabel,
                                commentLabel,
                                commentEmojiImageView,
                                dateLabel,
                                etcButton
                                )
        
        writerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
            $0.height.width.equalTo(38)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(writerImageView)
            $0.leading.equalTo(writerImageView.snp.trailing).offset(17)
        }
        
        commentLabel.snp.makeConstraints {
            $0.bottom.equalTo(writerImageView)
            $0.leading.equalTo(writerLabel)
        }
        
        commentEmojiImageView.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom)
            $0.leading.equalTo(writerLabel)
            $0.size.equalTo(84)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(writerLabel)
            $0.leading.equalTo(writerLabel.snp.trailing).offset(3)
        }
        
        etcButton.snp.makeConstraints {
            $0.centerY.equalTo(writerLabel)
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(42)
        }
    }
    
    func dataBind(data: ArchiveCommentModel){
        writerImageView.image = data.writerImage
        writerLabel.text = data.writerName
        commentLabel.text = data.comment
        dateLabel.text = data.date
    }
    
    func dataBind(data: CommentResult){
        if data.isEmoji{
            
            commentLabel.isHidden = true
            commentEmojiImageView.isHidden = false
            
            commentEmojiImageView.image = UIImage.zoocEmoji(data.emoji ?? 1)
        } else {
            commentLabel.isHidden = false
            commentEmojiImageView.isHidden = true
            
            commentLabel.text = data.content
        }
        
        if let imageURL = data.photo{
            writerImageView.kfSetImage(url: imageURL)
        } else {
            writerImageView.image = Image.defaultProfile
        }
        
        writerLabel.text = data.nickName
        dateLabel.text = data.date
    }
}
