//
//  HomeDetailArchiveViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class HomeDetailArchiveViewController : BaseViewController{
    
    //MARK: - Properties
    
    var detailArchiveData: HomeDetailArchiveModel = HomeDetailArchiveModel.mockData
    
    //MARK: - UI Components
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.xmark, for: .normal)
        button.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var etcButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.etc, for: .normal)
        button.addTarget(self, action: #selector(etcButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.previous, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(directionButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.next, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(directionButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocBody1
        label.textColor = .zoocGray2
        return label
    }()
    
    private let writerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let writerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocBody1
        label.textColor = .zoocGray2
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocBody3
        label.textColor = .zoocDarkGray2
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .zoocLightGray
        return view
    }()
    
    private let commentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        register()
    }
    
    //MARK: - Custom Method
    
    
    private func setUI(){
        petImageView.image = detailArchiveData.petImage
        dateLabel.text = detailArchiveData.date
        writerImageView.image = detailArchiveData.writerImage
        writerNameLabel.text = detailArchiveData.writerName
        contentLabel.text = detailArchiveData.content
    }
    
    private func setLayout(){
        view.addSubviews(
                         petImageView,
                         dismissButton,
                         etcButton,
                         previousButton,
                         nextButton,
                         dateLabel,
                         writerImageView,
                         writerNameLabel,
                         contentLabel,
                         lineView,
                         commentCollectionView
        )
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(11)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(42)
        }
        
        etcButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(11)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.width.equalTo(42)
        }
        
        petImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(petImageView.snp.width)
        }
        
        previousButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(185)
            $0.leading.equalToSuperview().offset(13)
            $0.width.height.equalTo(46)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(185)
            $0.trailing.equalToSuperview().offset(13)
            $0.width.height.equalTo(46)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(petImageView.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(30)
        }
        
        writerImageView.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(writerNameLabel.snp.leading).offset(-10)
            $0.height.width.equalTo(24)
        }
        
        writerNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(writerImageView)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        commentCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func register(){
        commentCollectionView.register(HomeCommentCollectionViewCell.self,
                                       forCellWithReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier)
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
    }
    
    //MARK: - Action Method
    
    @objc
    func dismissButtonDidTap(){
        dismiss(animated: true)
    }
    
    @objc
    func etcButtonDidTap(){
        print("더보기 버튼 눌렸습니다.")
    }
    
    @objc
    func directionButtonDidTap(_ sender: UIButton){
        switch sender.tag{
        case 0: print("previous 버튼이 눌렸습니다.")
        case 1: print("next 버튼이 눌렸습니다.")
        default: print("directionButtonDidTap 디폴트에 진입했씁니다.")
        }
    }
}

//MARK: - UICollectionViewDataSource
extension HomeDetailArchiveViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailArchiveData.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier, for: indexPath) as? HomeCommentCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: detailArchiveData.comments[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeDetailArchiveViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 36
        let height: CGFloat = 70
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
}

extension HomeDetailArchiveViewController{
    
    
    

}

