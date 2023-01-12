//
//  PracticeViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/31.
//

import UIKit

import SnapKit
import Then
import Photos

final class PracticeViewController : BaseViewController{
    
    //MARK: - Properties
    
    var photo = UIImage()
    var imageData : NSData?
    
    //MARK: - UI Components
    
    let label = UILabel().then {
        $0.font = .zoocDisplay2
        $0.text = "연습"
    }
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.gallery
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .zoocMainGreen
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
        
    }
    
    //MARK: - Custom Method
    
    
    private func setUI(){
        view.backgroundColor = .white
    }
    
    private func setLayout(){
        view.addSubviews(imageView,button)
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-100)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(80)
        }
    }
    
    //MARK: - Action Method
    
    @objc
    func buttonDidTap(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}
extension PracticeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photo = image
               self.imageView.image = image
           }
    }
}
