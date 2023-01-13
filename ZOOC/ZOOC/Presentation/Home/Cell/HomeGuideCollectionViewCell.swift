//
//  HomeRecordCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

final class HomeGuideCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = """
                        반려동물과의 순간을
                        쭉-기록해봐
                     """
        label.font = .zoocHeadLine
        label.textColor = .zoocDarkGray2
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = """
                        오래 추억할 수 있도록 ZOOC 남겨둘게!
                        옆으로 넘겨 첫 페이지를 기록해봐!
                     """
        label.font = .zoocBody1
        label.textColor = .zoocGray2
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let cardImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.graphics6
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    //MARK: - Custom Method
    
    private func setUI(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 24
        
        contentView.makeShadow(color: .zoocShadowGreenColor,
                               offset: .zero,
                               radius: 16,
                               opacity: 0.2)
    }
    
    private func setLayout(){
        contentView.addSubviews(titleLabel,descriptionLabel,cardImageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(42)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(42)
        }
        
        cardImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}

    
    
    
    
    
