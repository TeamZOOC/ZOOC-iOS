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
    
    private var detailArchiveMockData: HomeDetailArchiveModel = HomeDetailArchiveModel.mockData
    
    private var detailArchiveData: HomeDetailArchiveResult?
    private var commentData: [CommentResult] = []
    
    //MARK: - UI Components
    
    private let scrollView : UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    private let contentView = UIView()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.xmark, for: .normal)
        button.addTarget(self,
                         action: #selector(dismissButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var etcButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.etc, for: .normal)
        button.addTarget(self,
                         action: #selector(etcButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        button.tag = 1
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
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let commentTextField = HomeDetailArchiveCommentTextField()
    
    private lazy var commentEmojiButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.smile, for: .normal)
        button.addTarget(self,
                         action: #selector(emojiButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
    }

    //MARK: - Custom Method
    
    private func register(){
        commentCollectionView.register(HomeCommentCollectionViewCell.self,
                                       forCellWithReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier)
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
        commentTextField.commentDelegate = self
    }
    
    private func setUI(){
//        petImageView.image = detailArchiveMockData.petImage
//        dateLabel.text = detailArchiveMockData.date
//        writerImageView.image = detailArchiveMockData.writerImage
//        writerNameLabel.text = detailArchiveMockData.writerName
//        contentLabel.text = detailArchiveMockData.content
    }
    
    
    private func setLayout(){
        view.addSubviews(scrollView,
                         commentTextField,
                         commentEmojiButton)
        
        scrollView.addSubview(contentView)
        
        
        contentView.addSubviews(
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
        
        //MARK: View Layout
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-17)
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(47)
        }
        
        commentEmojiButton.snp.makeConstraints {
            $0.centerY.equalTo(commentTextField)
            $0.leading.equalTo(commentTextField.snp.trailing).offset(7)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.width.equalTo(30)
        }
        
        //MARK: ScrollView Layout
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(scrollView.contentSize.height).priority(.low)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        //MARK: ContentView Layout
        dismissButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(53)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(42)
        }
        
        etcButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(53)
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
            $0.trailing.equalToSuperview().offset(-13)
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
            $0.bottom.equalToSuperview()
        }
        
        
    }
    
    func getAPI(recordID: String){
        HomeAPI.shared.getDetailArchive(recordID: recordID) { result in
            guard let result = self.validateResult(result) as?  HomeDetailArchiveResult else { return }
            
            if let imageURL = result.record.writerPhoto{
                self.writerImageView.kfSetImage(url: imageURL)
                
            }
            else {
                self.writerImageView.image = Image.defaultProfile
            }
            
            self.petImageView.kfSetImage(url: result.record.photo)
            self.dateLabel.text = result.record.date
            self.writerNameLabel.text = result.record.writerName
            self.contentLabel.text = result.record.content
            self.commentData = result.comments
            self.commentCollectionView.reloadData()
            DispatchQueue.main.async {
                self.commentCollectionView.snp.remakeConstraints {
                    $0.top.equalTo(self.lineView.snp.bottom)
                    $0.leading.trailing.equalToSuperview()
                    $0.bottom.equalToSuperview()
                    $0.height.equalTo(self.commentCollectionView.contentSize.height)
                }
            }
        }
        
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
    
    @objc
    func emojiButtonDidTap(){
        print("이모지 버튼을 눌렸습니다.")
    }
}

//MARK: - UICollectionViewDataSource
extension HomeDetailArchiveViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return commentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier, for: indexPath) as? HomeCommentCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: commentData[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeDetailArchiveViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.frame.width - 36
        let height: CGFloat = 70
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
    }
}

extension HomeDetailArchiveViewController: CommentTextFieldDelegate{
    
    func commentTextFieldDidUplaod(_ textfield: HomeDetailArchiveCommentTextField,
                                   text: String) {
        print("VC에서 '\(text)'를 전달 받았습니다")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isUserInteractionEnabled = true
    }
    
    
}

