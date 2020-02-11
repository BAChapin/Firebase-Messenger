//
//  ViewController.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/3/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    private var logoView: UIImageView = {
        var view = UIImageView(image: UIImage(named: "Firebase"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    private var emailField: TextField = {
        var field = TextField()
        field.placeholder = "Email/Username"
        field.textContentType = .emailAddress
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .white
        return field
    }()
    private var passwordField: TextField = {
        var field = TextField()
        field.placeholder = "Password"
        field.textContentType = .password
        field.isSecureTextEntry = true
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .white
        return field
    }()
    private var loginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        setupEmailField()
        setupPasswordField()
        setupLoginButton()
        setupLogoView()
    }
    
    @objc func login() {
        guard let email = emailField.text, email != "" else {
            self.showNormalAlert(title: "No Email", message: "You need to enter an email address to login.", nil)
            return
        }
        
        guard let password = passwordField.text, password != "" else {
            self.showNormalAlert(title: "No Password", message: "You need to enter a password to login.", nil)
            return
        }
        
        FBService.shared.login(withEmail: email, password: password) { (snapshot, error) in
            if let fberror = error as? FBError {
                FBService.shared.user = User(uid: fberror.ammendment!)
                FBService.shared.user?.email = Auth.auth().currentUser!.email!
                self.showInputAlert(title: "User Info", placeholder1: "First Name", placeholder2: "Last Name") { (firstName, lastName) in
                    FBService.shared.user.firstName = firstName
                    FBService.shared.user.lastName = lastName
                    FBService.shared.user.initializeUserEntry({ (success, error) in
                        if let error = error {
                            print("LoginVC - \(#function) encountered an error: \(error.localizedDescription)")
                        } else {
                            print("LoginVC - \(#function) user account created, info saved.")
                            let vc = MessageListVC()
                            self.present(vc, animated: true)
                        }
                    })
                }
            } else if let error = error {
                print("LoginVC - \(#function) encountered an error: \(error.localizedDescription)")
            } else if let snapshot = snapshot {
                FBService.shared.user = User(snapshot: snapshot)
                let vc = MessageListVC()
                self.present(vc, animated: true)
            }
        }
    }

}

extension LoginVC {
    private func setupEmailField() {
        emailField.anchor(to: view,
                          leading: view.leadingAnchor,
                          trailing: view.trailingAnchor,
                          centerY: view.centerYAnchor,
                          padding: .init(top: 0,
                                         left: 25,
                                         bottom: 0,
                                         right: 25),
                          size: .init(width: 0,
                                      height: 35))
        
        emailField.border(width: 1.0)
        emailField.shadow(radius: 1, offset: .init(width: 3, height: 3))
        emailField.cornerRadius(radius: 5.0)
    }
    
    private func setupPasswordField() {
        passwordField.anchor(to: view,
                             top: emailField.bottomAnchor,
                             leading: view.leadingAnchor,
                             trailing: view.trailingAnchor,
                             padding: .init(top: 25,
                                            left: 25,
                                            bottom: 0,
                                            right: 25),
                             size: .init(width: 0,
                                         height: 35))
        
        passwordField.border(width: 1.0)
        passwordField.shadow(radius: 1, offset: .init(width: 3, height: 3))
        passwordField.cornerRadius(radius: 5.0)
    }
    
    private func setupLoginButton() {
        loginButton.anchor(to: view,
                           top: passwordField.bottomAnchor,
                           centerX: view.centerXAnchor,
                           padding: .init(top: 65,
                                          left: 0,
                                          bottom: 0,
                                          right: 0),
                           size: .init(width: 100,
                                       height: 45))
        
        loginButton.shadow(withOpacity: 0.3, radius: 5.0)
        loginButton.cornerRadius(radius: 5.0)
    }
    
    private func setupLogoView() {
        logoView.anchor(to: view,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        bottom: emailField.topAnchor,
                        padding: .init(top: 0,
                                       left: 50,
                                       bottom: 100,
                                       right: 50))
    }
}

