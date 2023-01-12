//
//  HomeMainCollectionViewCell.swift
//  ZOOC
//
//  Created by 장석우 on 2023/01/05.
//

import UIKit

import SnapKit

final class HomeArchiveGridCollectionViewCell : UICollectionViewCell{
    
    //MARK: - Properties
    
    
    //MARK: - UI Components
    
    private let petImageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
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
    //MARK: - Custom Method
    
    private func setUI(){
        contentView.backgroundColor = .zoocWhite1
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    private func setLayout(){
        contentView.addSubviews(petImageView)
       
        petImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
    }
    
    func dataBind(data: HomeArchiveModel){
        petImageView.image = data.petImage
    }
    
    func dataBind(data: HomeArchiveResult){
        petImageView.kfSetImage(url: data.record.photo)
    }
    
}
