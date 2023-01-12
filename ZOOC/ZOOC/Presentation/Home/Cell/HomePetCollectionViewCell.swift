//
//  HomePetCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/07.
//

import UIKit

final class HomePetCollectionViewCell: UICollectionViewCell{
    
    enum ViewType{
        case folded
        case expanded
    }
    
    //MARK: - Properties

    public var viewType: ViewType = .folded
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                switch viewType{
                case .folded:
                    viewType = .expanded
                    updateUI()
                case .expanded: break
                }
            }
            else {

                switch viewType{
                case .folded: break
                case .expanded:
                    viewType = .folded
                    updateUI()
                }
            }
        }
    }
    
    //MARK: - UI Components
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.font = .zoocBody1
        label.textColor = .zoocGray3
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewType{
        case .folded:  contentView.frame.size.width = 40
        case .expanded: break
        }
        contentView.layer.cornerRadius = 20
      
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        contentView.backgroundColor = .zoocWhite2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.zoocLightGray.cgColor
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
    private func setLayout(){
        contentView.addSubviews(petImageView,petNameLabel)
        updateUI()
    }
    
    public func dataBind(data: HomePetModel) {
        
        self.petImageView.image = data.image
        self.petNameLabel.text = data.name
    }
    
    public func dataBind(data: HomePetResult) {
        if data.photo == nil {
            self.petImageView.image = Image.defaultProfile
        } else {
            self.petImageView.kfSetImage(url: data.photo ?? "")
        }
        self.petNameLabel.text = data.name
    }
    
    private func updateUI(){
        
        switch viewType{
        case .folded:
            foldedLayout()
        case .expanded:
            expandedLayout()
        }
    }
    
    private func foldedLayout(){
        petImageView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        petNameLabel.isHidden = true
        
    }
    
    private func expandedLayout(){
        petNameLabel.isHidden = false
        
        petImageView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(3)
            $0.height.width.equalTo(34)
        }
        
        petNameLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(petImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-14)
        }
        
    }
    
    func sizeFittingWith(cellHeight: CGFloat) -> CGSize {
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: cellHeight)
        return self.contentView.systemLayoutSizeFitting(targetSize,
                                                        withHorizontalFittingPriority: .fittingSizeLevel,
                                                        verticalFittingPriority: .required)
    }
    
    
}
