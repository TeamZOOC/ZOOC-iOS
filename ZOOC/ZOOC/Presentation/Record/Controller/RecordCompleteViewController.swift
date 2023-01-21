//
//  RecordComplete.swift
//  ZOOC
//
//  Created by 정윤선 on 2023/01/10.
//

import UIKit

import SnapKit

final class RecordCompleteViewController : BaseViewController {
    
    //MARK: - Properties
    
    var firstPetID: Int?
    
    //MARK: - UI Components
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "등록 완료!"
        label.textColor = .zoocDarkGray1
        label.font = .zoocSubhead2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가족들에게 게시글 알림을 보냈어요!"
        label.textColor = .zoocGray1
        label.font = .zoocBody2
        return label
    }()
    
    private let notifyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.graphics7
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var goArchiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("아카이브 보러 가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .zoocSubhead1
        button.backgroundColor = .zoocMainGreen
        button.layer.cornerRadius = 13
        button.addTarget(self, action: #selector(goArchiveButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    //MARK: - Custom Method
    
    private func setLayout(){
        view.addSubview(cardView)
        
        cardView.addSubviews(titleLabel,
                             subtitleLabel,
                             notifyImageView,
                             goArchiveButton)
            
        //MARK: - MakeConstraints
        
        cardView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(456)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.cardView.snp.top).offset(54)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        notifyImageView.snp.makeConstraints {
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(227)
            $0.height.equalTo(227)
        }
        
        goArchiveButton.snp.makeConstraints {
            $0.top.equalTo(self.notifyImageView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(22)
        }
    }
    
    func dataBind(data: [Int]){
        firstPetID = data.first
    }
    
    //MARK: - Action Method
    
    @objc
    private func goArchiveButtonDidTap() {
        
        guard let tabVC = navigationController?.previousViewController?.presentingViewController as? ZoocTabBarController else { return }
        
        guard let petID = firstPetID else { return }
        tabVC.homeViewController.selectPetCollectionView(petID: petID)
        
        self.navigationController?.previousViewController?.navigationController?.previousViewController?.dismiss(animated: true)
    }
}
