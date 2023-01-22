//
//  HomeDetailArchiveViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/05.
//

import UIKit

import SnapKit
import Then

final class HomeDetailArchiveViewController : BaseViewController {
    
    //MARK: - Properties
    
    private var detailArchiveMockData: HomeDetailArchiveModel = HomeDetailArchiveModel.mockData
    
    var petID: String = "1"
    private var detailArchiveData: HomeDetailArchiveResult? {
        didSet{
            updateUI()
        }
    }
    private var commentData: [CommentResult] = []
    
    enum PageDirection: Int{
        case left
        case right
    }
    
    //MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let backButton = UIButton()
    private let etcButton = UIButton()
    
    private let petImageView = UIImageView()
    private let leftButton = UIButton()
    private let rightButton = UIButton ()
    
    private let dateLabel = UILabel()
    private let writerImageView = UIImageView()
    private let writerNameLabel = UILabel()
    private let contentLabel = UILabel()
    private let lineView = UIView()
    
    private let commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let commentTextField = HomeDetailArchiveCommentTextField()
    private let commentEmojiButton = UIButton()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        gesture()
        
        style()
        hierarchy()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    

    //MARK: - Custom Method
    
    private func register() {
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        commentTextField.commentDelegate = self
        
        commentCollectionView.register(HomeCommentCollectionViewCell.self,
                                       forCellWithReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier)
    }
    
    private func gesture() {
        backButton.addTarget(self,
                             action: #selector(backButtonDidTap),
                             for: .touchUpInside)

        etcButton.addTarget(self,
                            action: #selector(etcButtonDidTap),
                            for: .touchUpInside)
         
        leftButton.addTarget(self,
                                 action: #selector(directionButtonDidTap),
                                 for: .touchUpInside)
        
        rightButton.addTarget(self,
                             action: #selector(directionButtonDidTap),
                             for: .touchUpInside)
        
        commentEmojiButton.addTarget(self,
                                     action: #selector(emojiButtonDidTap),
                                     for: .touchUpInside)
    }
    
    private func style() {
        scrollView.do {
            $0.bounces = false
            $0.showsVerticalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentInsetAdjustmentBehavior = .never
        }
        
        backButton.do {
            $0.setImage(Image.xmark, for: .normal)
        }
        
        etcButton.do {
            $0.setImage(Image.etc, for: .normal)
        }
        
        petImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        leftButton.do {
            $0.setImage(Image.previous, for: .normal)
            $0.tag = 0
        }
        
        rightButton.do {
            $0.setImage(Image.next, for: .normal)
            $0.tag = 1
        }
        
        dateLabel.do {
            $0.font = .zoocBody1
            $0.textColor = .zoocGray2
        }
        
        writerImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }
        
        writerNameLabel.do {
            $0.font = .zoocBody1
            $0.textColor = .zoocGray2
        }
        
        contentLabel.do {
            $0.font = .zoocBody3
            $0.textColor = .zoocDarkGray2
        }
        
        lineView.do {
            $0.backgroundColor = .zoocLightGray
        }
        
        commentCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            $0.collectionViewLayout = layout
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
        }
        
        commentEmojiButton.do {
            $0.setImage(Image.smile, for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func hierarchy() {
        view.addSubviews(scrollView,
                         commentTextField,
                         commentEmojiButton)
        
        scrollView.addSubview(contentView)
        
        
        contentView.addSubviews(petImageView,
                                 backButton,
                                 etcButton,
                                 leftButton,
                                 rightButton,
                                 dateLabel,
                                 writerImageView,
                                 writerNameLabel,
                                 contentLabel,
                                 lineView,
                                 commentCollectionView)
    }
    
    private func layout() {
  
        //MARK: view Layout
        
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
        
        //MARK: scrollView Layout
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(scrollView.contentSize.height).priority(.low)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        //MARK: contentView Layout
        
        backButton.snp.makeConstraints {
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
        
        leftButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(185)
            $0.leading.equalToSuperview().offset(13)
            $0.width.height.equalTo(46)
        }
        
        rightButton.snp.makeConstraints {
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
            $0.height.greaterThanOrEqualTo(200)
        }
    }
    
    private func updateUI() {
        if let imageURL = detailArchiveData?.record.writerPhoto{
            self.writerImageView.kfSetImage(url: imageURL)
        } else {
            self.writerImageView.image = Image.defaultProfile
        }
        
        self.petImageView.kfSetImage(url: detailArchiveData?.record.photo)
        self.dateLabel.text = detailArchiveData?.record.date
        self.writerNameLabel.text = detailArchiveData?.record.writerName
        self.contentLabel.text = detailArchiveData?.record.content
        self.commentData = detailArchiveData?.comments ?? []
        self.commentCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.commentCollectionView.snp.updateConstraints {
                $0.height.greaterThanOrEqualTo(self.commentCollectionView.contentSize.height)
            }
        }
    }
    
    func requestDetailArchiveAPI(recordID: String, petID: String) {
        HomeAPI.shared.getDetailPetArchive(recordID: recordID, petID: petID) { result in
            guard let result = self.validateResult(result) as?  HomeDetailArchiveResult else { return }
            
            self.detailArchiveData = result
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func etcButtonDidTap() {
        presentBottomAlert("더보기 기능은 곧 만나요~")
    }
    
    @objc
    func directionButtonDidTap(_ sender: UIButton) {
        guard let direction = PageDirection.init(rawValue: sender.tag) else { return }
        var message: String
        var id: Int?
        
        switch direction {
        case .left:
            message = "가장 최근 페이지입니다."
            id = detailArchiveData?.leftID
        case .right:
            message = "마지막 페이지 입니다."
            id = detailArchiveData?.rightID
        }
        
        guard let id = id else {
            presentBottomAlert(message)
            return
        }
        
        requestDetailArchiveAPI(recordID: String(id), petID: petID)
    }
    
    @objc
    func emojiButtonDidTap() {
        presentBottomAlert("이모지 기능은 곧 만나요~")
    }
}

//MARK: - UICollectionViewDataSource
extension HomeDetailArchiveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return commentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier, for: indexPath) as? HomeCommentCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(data: commentData[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeDetailArchiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 36        
        if commentData[indexPath.row].isEmoji{
            return CGSize(width: width, height: 126)
        } else {
            return CGSize(width: width, height: 70)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
    }
}

extension HomeDetailArchiveViewController: CommentTextFieldDelegate {
    
    func commentTextFieldDidUplaod(_ textfield: HomeDetailArchiveCommentTextField,
                                   text: String) {
        print("VC에서 '\(text)'를 전달 받았습니다")
        HomeAPI.shared.postComment(recordID: "\(detailArchiveData?.record.id ?? 1)",
                                   comment: text) { result in
            guard let result = self.validateResult(result) as? [CommentResult] else { return }
            self.commentData = result
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
}
