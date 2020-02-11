//
//  TextField.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/10/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import UIKit

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
