//
//  HomeMainCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/05.
//

import UIKit

import SnapKit

final class HomeRecordCollectionViewCell : UICollectionViewCell{
    
    enum ViewType{
        case folded
        case expanded
    }
    
    //MARK: - Properties
    
    public var viewType : ViewType = .folded
    private var indexPath : IndexPath = IndexPath(item: 100, section: 100)
    
    override var isSelected: Bool{
        didSet{
//            print("--------------------------------------------")
//            print("\(indexPath.row)번째 Cell - isSelected 값: \(isSelected)")
//            
            switch viewType{
            case .folded:
                viewType = .expanded
                updateUI()
            case .expanded:
                viewType = .folded
                updateUI()
                
            }
        }
    }
    
    //MARK: - UI Components
    
    private let petImageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let contentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .zoocDarkGray1
        label.font = .zoocBody1
        label.numberOfLines = 0
        return label
    }()
    
    private let profileImageView : UIImageView = {
        let view = UIImageView()
        view.image = Image.profileImage
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "1/5"
        label.font = .zoocCaption
        label.textColor = .zoocGray2
        return label
    }()
    
        //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isSelected = false
        viewType = .folded
        foldedLayout()
        indexPath = IndexPath(row: -1, section: 0)
    }
    
    
    
    //MARK: - Custom Method
    
    private func setUI(){
        contentView.backgroundColor = .zoocWhite1
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        contentLabel.isHidden = true
    }
    
    private func setLayout(){
        contentView.addSubviews(petImageView,contentLabel,profileImageView,dateLabel)
        
        petImageView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(280)
        }
        
        foldedLayout()
    }
    
    private func foldedLayout(){
        foldedProfileLayout()
        dateLabel.snp.remakeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func foldedProfileLayout(){
        profileImageView.snp.remakeConstraints {
            $0.top.equalTo(petImageView.snp.bottom).offset(84)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(24)
        }
    }
    
    private func foldedDateLabelLayout(){
        dateLabel.snp.remakeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    private func expandedLayout(){
        profileImageView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.width.equalTo(24)
        }
        
        dateLabel.snp.remakeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func updateUI(){
        switch viewType{
        case .folded:
            UIView.animate(withDuration: TimeInterval(0.3)) {
                self.foldedProfileLayout()
                self.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: TimeInterval(0.5)) {
                self.foldedDateLabelLayout()
                self.layoutIfNeeded()
            }
            
        case .expanded:
            UIView.animate(withDuration: TimeInterval(0.5)) {
                self.expandedLayout()
                self.layoutIfNeeded()
            }
        }
    }
    
    func dataBind(_ viewType: ViewType, data: HomeRecordModel){
        
        petImageView.image = data.petImage
        contentLabel.text = data.content
        profileImageView.image = data.profileImage
        dateLabel.text = data.date
        
        switch viewType{
        case .folded:
            foldedLayout()
        case .expanded:
            expandedLayout()
        }
    }
    
    func dataBind(_ indexPath: IndexPath){
        self.indexPath = indexPath
        self.dateLabel.text = "\(indexPath.row)"
    }
    
  
    
    
}
