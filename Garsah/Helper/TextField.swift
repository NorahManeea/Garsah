//
//  TextField.swift
//  Garsah
//
//  Created by Norah Almaneea on 20/05/2022.
//

import Foundation
import UIKit

class TextField {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 192/255, blue: 88/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleButton(_ button:UIButton) {
        
        button.backgroundColor = UIColor.init(red: 58/255, green: 85/255, blue: 67/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.tintColor = UIColor.white
    }

    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

    
}

