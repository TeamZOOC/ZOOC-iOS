//
//  RecordViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit

import SnapKit
import Then

final class RecordViewController : BaseViewController{
    
    //MARK: - Properties
    
    private var recordData: RecordModel? = RecordModel(image: Image.mockPet1, content: nil)
    private let placeHoldText: String = """
                                        ex) 2023년 2월 30일
                                        가족에게 어떤 순간이었는지 남겨주세요
                                        """
    //MARK: - UI Components
    
    private let topBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.xmark,
                        for: .normal)
        button.addTarget(self,
                         action: #selector(xButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private let buttonsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("일상", for: .normal)
        button.titleLabel?.font = .zoocSubhead1
        button.setTitleColor(.zoocDarkGray1, for: .normal)
        button.addTarget(self,
                         action: #selector(dailyButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var missionButton: UIButton = {
        let button = UIButton()
        button.setTitle("미션", for: .normal)
        button.titleLabel?.font = .zoocSubhead1
        button.setTitleColor(.zoocGray1, for: .normal)
        button.addTarget(self,
                         action: #selector(missionButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.zoocSubGreen.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 14
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.backgroundColor = .white
        return view
    }()
    
    private let addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.gallery
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 16.0, left: 18.0, bottom: 16.0, right: 18.0)
        textView.font = .zoocBody2
        textView.text = placeHoldText
        textView.textColor = .zoocGray1
        textView.backgroundColor = .zoocWhite2
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 12
        
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 10
//        let attributes = [NSAttributedString.Key.paragraphStyle : style]
//        textView.attributedText = NSAttributedString(string: placeHoldText,
//                                                     attributes: attributes)
        return textView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .zoocSubhead1
        button.setTitleColor(.zoocWhite1, for: .normal)
        button.backgroundColor = .zoocGray1
        button.isEnabled = false
        button.layer.cornerRadius = 27
        button.addTarget(self,
                         action: #selector(nextButtonDidTap),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        contentTextView.delegate = self
    }
    
    //MARK: - Custom Method
    
    private func setLayout() {
        view.addSubviews(topBarView, cardView, nextButton)
        
        topBarView.addSubviews(xmarkButton, buttonsContainerView)
        
        buttonsContainerView.addSubviews(dailyButton, missionButton)
        
        cardView.addSubviews(addImageView, contentTextView)
        
        topBarView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(11)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(42)
        }
        
        xmarkButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(22)
            $0.width.equalTo(42)
            $0.height.equalTo(42)
        }
        
        buttonsContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(22)
            $0.width.equalTo(112)
            $0.height.equalTo(42)
        }
        
        dailyButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(self.missionButton.snp.leading)
            $0.width.equalTo(56)
            $0.height.equalTo(42)
        }
        
        missionButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(56)
            $0.height.equalTo(42)
        }
        
        cardView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(477)
        }
        
        addImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(210)
        }
        
        contentTextView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(210)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(54)
        }
    }
    
    func pushToRecordAlertViewController() {
        let recordAlertViewController = RecordAlertViewController()
        recordAlertViewController.modalPresentationStyle = .overFullScreen
        self.present(recordAlertViewController, animated: false, completion: nil)
    }
    
    func pushToRecordRegisterViewController() {
        let recordRegisterViewController = RecordRegisterViewController()
        navigationController?.pushViewController(recordRegisterViewController, animated: true)
        print(#function)
    }
    
    //MARK: - Action Method
    
    @objc private func xButtonDidTap(){
        pushToRecordAlertViewController()
    }
    
    @objc private func dailyButtonDidTap(){
        print(#function)
    }
    
    @objc private func missionButtonDidTap(){
        print(#function)
    }
    
    @objc
    private func textViewDidTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc
    private func nextButtonDidTap(_ sender: Any) {
        pushToRecordRegisterViewController()
    }
}

extension RecordViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHoldText {
            textView.text = nil
            textView.textColor = .black
        } else{
            
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeHoldText
            textView.textColor = .zoocGray1
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            nextButton.backgroundColor = .zoocGray1
            nextButton.isEnabled = false
        } else {
            nextButton.backgroundColor = .zoocGradientGreen
            nextButton.isEnabled = true
        }
    }
}
