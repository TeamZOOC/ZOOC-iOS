//
//  RecordRegisterViewController.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/09.
//

import UIKit

import SnapKit
import Then

final class RecordRegisterViewController : BaseViewController{
    
    // MARK: - Properties
    
    var petList: [RecordRegisterModel] = [
        RecordRegisterModel(profilePetImage: Image.mockPet1, petName: "토리", selectButton: false),
        RecordRegisterModel(profilePetImage: Image.mockPet1, petName: "토리", selectButton: false),
        RecordRegisterModel(profilePetImage: Image.mockPet1, petName: "토리", selectButton: false)
    ]
    
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
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.backCircle, for: .normal)
        button.addTarget(self,
                        action: #selector(backButtonDidTap),
                        for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "반려동물 선택"
        label.font = .zoocSubhead2
        label.textColor = .zoocDarkGray1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "어디에 기록을 남길까요?"
        label.font = .zoocBody2
        label.textColor = .zoocGray1
        return label
    }()
    
    private lazy var recordRegisterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = true // TODO: 공부
        // collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록하기", for: .normal)
        button.setTitleColor(.zoocWhite1, for: .normal)
        button.backgroundColor = .zoocMainGreen
        button.layer.cornerRadius = 27
        button.addTarget(self,
                         action: #selector(registerButtonDidTap),
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
    
    //MARK: - Custom Method
    
    private func setUI(){
        
    }
    
    private func setLayout(){
        view.addSubviews(topBarView, cardView, registerButton)
        
        topBarView.addSubviews(xmarkButton, buttonsContainerView)

        buttonsContainerView.addSubviews(dailyButton, missionButton)

        cardView.addSubviews(headerView, recordRegisterCollectionView)
        
        headerView.addSubviews(backButton, titleLabel, subtitleLabel)

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
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(125)
        }
        
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        recordRegisterCollectionView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(352)
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(54)
        }
    }
    
    //MARK: - Action Method

    private func register() {
        recordRegisterCollectionView.register(RecordRegisterCollectionViewCell.self, forCellWithReuseIdentifier: RecordRegisterCollectionViewCell.cellIdentifier)
    }
    
    @objc
    private func xButtonDidTap(){
        dismiss(animated: true)
    }
    
    @objc
    private func dailyButtonDidTap(){
        dismiss(animated: true)
    }

    @objc
    private func missionButtonDidTap(){
        dismiss(animated: true)
    }
    
    @objc
    private func backButtonDidTap(){
        dismiss(animated: true)
    }
    
    @objc
    private func registerButtonDidTap(){
        dismiss(animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension RecordRegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecordRegisterCollectionViewCell.cellIdentifier, for: indexPath)
                as? RecordRegisterCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(model: petList[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension RecordRegisterViewController{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RecordRegisterCollectionViewCell else { return }
        cell.updateUI(isSelected: true) //TODO: 클래스와 프로퍼티, 메소드에 접근 | private public | 타입캐스팅 
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RecordRegisterCollectionViewCell else { return }
        cell.updateUI(isSelected: false)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RecordRegisterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: Int = 352 / petList.count
        return CGSize(width: 315, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

