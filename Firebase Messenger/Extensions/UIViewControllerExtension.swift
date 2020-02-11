//
//  UIViewControllerExtension.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/11/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import UIKit

extension UIViewController {
    func showNormalAlert(title: String, message: String, _ completionOK: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: completionOK))
        present(alert, animated: true)
    }
    
    func showConfirmationAlert(title: String, message: String, _ completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            completion(false)
        }))
        present(alert, animated: true)
    }
    
    func showInputAlert(title: String, placeholder1: String, placeholder2: String, _ completion: @escaping (String, String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = placeholder1
        }
        alert.addTextField { (textField) in
            textField.placeholder = placeholder2
        }
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            completion(alert.textFields![0].text!, alert.textFields![1].text!)
        }))
        present(alert, animated: true)
    }
}
