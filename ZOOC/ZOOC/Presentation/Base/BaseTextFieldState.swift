//
//  BaseTextFieldState.swift
//  ZOOC
//
//  Created by 류희재 on 2023/02/26.
//

import UIKit

enum BaseTextFieldState {
    case isFull
    case isEmpty
    case isWritten
    
    var backgroundColor: UIColor {
        switch self {
        case .isFull:
            return .zoocGray1
        case .isEmpty:
            return .zoocGray1
        case .isWritten:
            return .zoocDarkGreen
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .isFull:
            return .zoocDarkGreen
        case .isEmpty:
            return .zoocGray1
        case .isWritten:
            return .zoocDarkGreen
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .isFull:
            return .zoocGradientGreen
        case .isEmpty:
            return .zoocGray1
        case .isWritten:
            return .zoocGradientGreen
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .isFull:
            return true
        case .isEmpty:
            return false
        case .isWritten:
            return true
        }
    }
    
    func setTextFieldState(textField: UITextField?,
                           underLineView: UIView?,
                           button: UIButton?) {
        underLineView?.backgroundColor = self.backgroundColor
        textField?.textColor = self.textColor
        button?.backgroundColor = self.buttonColor
        button?.isEnabled = self.isEnabled
    }
}
