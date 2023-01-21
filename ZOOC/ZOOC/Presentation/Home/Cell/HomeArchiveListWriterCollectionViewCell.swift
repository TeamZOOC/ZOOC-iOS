//
//  HomeArchiveListWriterCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/12.
//

import UIKit

import SnapKit

final class HomeArchiveListWriterCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    

    
    //MARK: - UI Components
    
    private let writerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    private func setUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    private func setLayout() {
        contentView.addSubview(writerImageView)
        
        writerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dataBind(data: CommentWriterResult) {
        print(data)
        guard let imageURL = data.writerPhoto else {
            writerImageView.image = Image.defaultProfile
            return
        }
        writerImageView.kfSetImage(url: imageURL)
        
    }
    //MARK: - Action Method

}
