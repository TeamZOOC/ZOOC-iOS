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
    
    enum PageDirection: Int{
        case left
        case right
    }
    
    private var detailArchiveMockData: HomeDetailArchiveModel = HomeDetailArchiveModel.mockData
    
    var petID: String = "1"
    var isNewPage = true
    
    private var detailArchiveData: HomeDetailArchiveResult? {
        didSet{
            updateArchiveUI()
        }
    }
    
    private var commentsData: [CommentResult] = [] {
        didSet{
            updateCommentsUI()
        }
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
    
    private let commentView = HomeDetailArchiveCommentView()
    
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardNotifications()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        commentView.layoutIfNeeded()
    }

    //MARK: - Custom Method
    
    private func register() {
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        commentView.delegate = self
        
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
        
    }
    
    private func hierarchy() {
        view.addSubviews(scrollView,
                         commentView)
        
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
        
        commentView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(19)
            $0.height.equalTo(64)
        }
        
        //MARK: scrollView Layout
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.width.equalTo(scrollView.frameLayoutGuide)
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
            $0.height.greaterThanOrEqualTo(450)
        }
    }
    
    private func updateArchiveUI() {
        if let imageURL = detailArchiveData?.record.writerPhoto{
            self.writerImageView.kfSetImage(url: imageURL)
        } else {
            self.writerImageView.image = Image.defaultProfile
        }
        
        self.petImageView.kfSetImage(url: detailArchiveData?.record.photo)
        self.dateLabel.text = detailArchiveData?.record.date
        self.writerNameLabel.text = detailArchiveData?.record.writerName
        self.contentLabel.text = detailArchiveData?.record.content
    }
    
    private func updateCommentsUI() {
        commentCollectionView.reloadData()
        commentCollectionView.layoutIfNeeded()
        commentCollectionView.snp.updateConstraints {
            let contentHeight = self.commentCollectionView.contentSize.height
            let height = (contentHeight > 450 ) ? contentHeight : 450
            $0.height.greaterThanOrEqualTo(height)
        }
        
        if isNewPage{
            isNewPage = false
        } else{
            scrollView.layoutSubviews()
            self.scrollView.setContentOffset(CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.height), animated: true)
        }
        
    }
    
    func requestDetailArchiveAPI(recordID: String, petID: String) {
        HomeAPI.shared.getDetailPetArchive(recordID: recordID, petID: petID) { result in
            guard let result = self.validateResult(result) as?  HomeDetailArchiveResult else { return }
            
            self.isNewPage = true
            self.detailArchiveData = result
            self.commentsData = result.comments
        }
    }
    
    private func requestCommentsAPI(recordID: String, text: String) {
        HomeAPI.shared.postComment(recordID: recordID, comment: text) { result in
            guard let result = self.validateResult(result) as? [CommentResult] else { return }
            
            self.commentsData = result
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func etcButtonDidTap() {
        presentBottomAlert("더보기 기능은 곧 만나요~")
    }
    
    @objc
    private func directionButtonDidTap(_ sender: UIButton) {
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
    internal func emojiButtonDidTap() {
        presentBottomAlert("이모지 기능은 곧 만나요~")
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification){
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        UIView.animate(withDuration: duration){
            self.commentView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(keyboardHeight)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc
    private func keyboardWillHide(notification: NSNotification){
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        UIView.animate(withDuration: duration){
            self.commentView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(19)
            }
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension HomeDetailArchiveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return commentsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCommentCollectionViewCell.cellIdentifier, for: indexPath) as? HomeCommentCollectionViewCell else { return UICollectionViewCell() }
        
        cell.dataBind(data: commentsData[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeDetailArchiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 36        
        if commentsData[indexPath.item].isEmoji{
            return CGSize(width: width, height: 126)
        } else {
            return CGSize(width: width, height: 70)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 18, bottom: 30, right: 18)
    }
}

//MARK: - CommentViewDelegate

extension HomeDetailArchiveViewController: HomeCommentViewDelegate{
    
    func uploadButtonDidTap(_ textField: UITextField, text: String) {
        guard let id = detailArchiveData?.record.id else { return }
        textField.text = nil
        requestCommentsAPI(recordID: String(id), text: text)
    }
    
    
}
