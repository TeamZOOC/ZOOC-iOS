//
//  GalleryAlertViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2023/02/28.
//

import UIKit

import SnapKit
import Then

protocol GalleryAlertControllerDelegate: AnyObject {
    func galleryButtonDidTap()
    func deleteButtonDidTap()
}

final class GalleryAlertController : UIAlertController {
    
    //MARK: - Properties
    
    weak var delegate: GalleryAlertControllerDelegate?
    
    //MARK: - UI Components
    
    private lazy var galleryAction = UIAlertAction(title: "사진 보관함", style: .default) { action in
        self.delegate?.galleryButtonDidTap()
    }
    
    private lazy var deleteAction = UIAlertAction(title: "사진 삭제", style: .destructive) { action in
        self.delegate?.deleteButtonDidTap()
    }
    private let cancleAction = UIAlertAction(title: "취소", style: .cancel)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        style()
        hierarchy()
        layout()
    }
    
    //MARK: - Custom Method
    
    private func target() {
        addAction(galleryAction)
        addAction(deleteAction)
        addAction(cancleAction)
    }
    
    private func style() {
        
    }
    
    private func hierarchy() {
        
    }
    
    private func layout() {
        
    }
    
    //MARK: - Action Method
    
}

