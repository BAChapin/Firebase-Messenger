//
//  MessageListVC.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/11/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import UIKit

class MessageListVC: UIViewController {
    private var textView: UILabel = {
        let view = UILabel()
        view.text = "You are successfully logged in, \(FBService.shared.user.firstName)!"
        view.textColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupTextView()
    }
}

extension MessageListVC {
    private func setupTextView() {
        textView.anchor(to: view,
                        centerX: view.centerXAnchor,
                        centerY: view.centerYAnchor)
    }
}
