//
//  HomeCardCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/01.
//

import UIKit

import SnapKit
import Then

protocol HomeMissionCardDelegate: AnyObject{
    func nextButtonDidTap(_ text: String)
    
}

final class HomeMissionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: HomeMissionCardDelegate?
    
    //MARK: - UI Components
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = """
                        최근 나를 웃게 했던
                        반려동물 사진이 뭐야?
                     """
        label.font = .zoocSubhead1
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
    
    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .zoocMainGreen
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .zoocSubhead1
        button.addTarget(self,
                         action: #selector(nextButtonDidTap),
                         for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
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
    
    private func setDelegate() {
        textView.delegate = self
    }
    
    private func setUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 24
        
        contentView.makeShadow(color: .zoocShadowGreenColor,
                               offset: CGSize(width: 0, height: 0),
                               radius: 14,
                               opacity: 0.2)
    }
    
    private func setLayout() {
        contentView.addSubviews(titleLabel,galleryImageView,textView, nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        galleryImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(210)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(galleryImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(galleryImageView)
        }
        //asdfasdf
        nextButton.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(textView)
            $0.bottom.equalToSuperview().offset(-22)
            $0.height.equalTo(52)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    private func nextButtonDidTap() {
        print("delegate로 보내자")
        delegate?.nextButtonDidTap(textView.text)
    }
    
}

extension HomeMissionCollectionViewCell: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .zoocGray1 else { return }
        textView.text = nil
        textView.textColor = .zoocDarkGray2
    }
    
}

    
    
    
    
    
