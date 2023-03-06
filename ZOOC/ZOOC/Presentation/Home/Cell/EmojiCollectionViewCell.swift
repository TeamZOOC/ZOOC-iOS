//
//  HomeCommentCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/25.
//

import UIKit

import SnapKit
import Then

final class EmojiCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var emojiData: EmojiModel?{
        didSet{
            updateUI()
        }
    }
    
    //MARK: - UI Components
    
    private let emojiImageView = UIImageView()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func style() {
        emojiImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func hierarchy() {
        contentView.addSubview(emojiImageView)
    }
    
    private func layout() {
        emojiImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateUI(){
        emojiImageView.image = emojiData?.image
    }
    
    func dataBind(data: EmojiModel) {
        emojiData = data
    }
}
