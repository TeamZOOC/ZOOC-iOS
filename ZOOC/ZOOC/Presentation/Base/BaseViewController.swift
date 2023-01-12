//
//  BaseViewController.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/25.
//

import UIKit

import SnapKit
import Then

class BaseViewController : UIViewController{
    
    //MARK: - Properties
    
    //MARK: - UI Components
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        view.backgroundColor = .zoocBackgroundGreen
    }
    
    private func setLayout(){
        
    }
    
    func validateResult(_ result: NetworkResult<Any>) -> Any?{
        switch result{
        case .success(let data):
            print("성공했습니다.")
            print(data)
            return data
        case .requestErr(let message):
            presentBottomAlert(message)
        case .pathErr:
            presentBottomAlert("잘못된 경로입니다.")
        case .serverErr:
            presentBottomAlert("서버 오류 혹은 메소드 오류입니다.")
        case .networkFail:
            presentBottomAlert("네트워크가 불안정합니다.")
        case .decodedErr:
            presentBottomAlert("디코딩 오류가 발생했습니다.")
        }
        return nil
    }
    
    //MARK: - Keyboard 관련 처리
   
    
    //MARK: - Action Method
    
}
