//
//  EditProfileViewController.swift
//  ZOOC
//
//  Created by 류희재 on 2023/01/04.
//

import UIKit

import SnapKit
import Then

final class  EditProfileViewController: BaseViewController {
    
    //MARK: - Properties
    
    private lazy var editProfileView = EditProfileView()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Custom Method
    
    func dataSend(profileName: String, profileImage: UIImage) {
        editProfileView.editProfileImageButton.setImage(profileImage, for: .normal)
        editProfileView.editProfileNameTextField.placeholder = profileName
    }
    
    func register() {
        //editProfileView.editProfileNameTextField.delegate = self
    }
}

// 글자 수 관련 내용
//extension EditProfileViewController: UITextFieldDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//            /// 글자 수 제한
//        if editProfileView.editProfileNameTextField.text!!.count ?? <#default value#> > 150 {
//            editProfileView.editProfileNameTextField.deleteBackward()
//            }
//
//            /// 아래 글자 수 표시되게 하기
//            letterNumLabel.text = "\(activityTextView.text.count)/150"
//
//            /// 글자 수 부분 색상 변경
//            let attributedString = NSMutableAttributedString(string: "\(activityTextView.text.count)/150")
//            attributedString.addAttribute(.foregroundColor, value: UIColor.pink100, range: ("\(activityTextView.text.count)/150" as NSString).range(of:"\(activityTextView.text.count)"))
//            letterNumLabel.attributedText = attributedString
//        }
//}
