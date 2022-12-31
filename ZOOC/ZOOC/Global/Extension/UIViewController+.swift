//
//  UIViewController+.swift
//  ZOOC
//
//  Created by 장석우 on 2022/12/21.
//

import UIKit

extension UIViewController{
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func presentBottomAlert(_ message: String) {
      
        let alertSuperview : UIView = {
            let view = UIView()
            view.backgroundColor = .darkGray.withAlphaComponent(0.85)
            view.layer.cornerRadius = 10
            view.isHidden = true
            return view
        }()
    
        
        let alertLabel : UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            label.textColor = .white
            label.text = message
            return label
        }()
        
        view.addSubview(alertSuperview)
        alertSuperview.addSubview(alertLabel)
        alertSuperview.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(35)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        alertLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }

}
