//
//  HomeCardCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

final class OnboardingMissionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = """
                        최근 나를 웃게 했던
                        반려동물 사진이 뭐야?
                     """
        label.font = .zoocSubhead2
        label.textColor = .zoocDarkGray1
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let galleryImageView : UIImageView = {
        let view = UIImageView()
        view.image = Image.gallery
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var textView : UITextView = {
        let view = UITextView()
        view.backgroundColor = .zoocWhite1
        view.layer.cornerRadius = 12
        view.text = "오늘 어떤 일이 있었는지 공유해보세요"
        view.textColor = .zoocGray1
        view.font = .zoocBody1
        return view
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDelegate()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        textView.delegate = self
    }
    
    private func setUI(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 24
        
        contentView.makeShadow(color: .zoocShadowGreenColor,
                               offset: CGSize(width: 0, height: 0),
                               radius: 14,
                               opacity: 0.2)
    }
    
    private func setLayout(){
        contentView.addSubviews(titleLabel,galleryImageView,textView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(46)
            $0.centerX.equalToSuperview()
        }
        
        galleryImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(210)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(galleryImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(galleryImageView)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
}

extension OnboardingMissionCollectionViewCell: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        guard textView.textColor == .zoocGray1 else { return }
        textView.text = nil
        textView.textColor = .zoocDarkGray2
    }
    
}

    
    
    
    
    
