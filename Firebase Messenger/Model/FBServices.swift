//
//  FBServices.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/11/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import UIKit
import Firebase

class FBService {
    
    static var shared = FBService()
    
    var user: User!
    
    static let userCollection = Firestore.firestore().collection("users")
    
    func login(withEmail email: String, password: String, _ completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let firCode = AuthErrorCode(rawValue: error._code) {
                print("FBService - \(#function) encountered an error: \(error.localizedDescription)")
                switch firCode.rawValue {
                case 17011:
                    self.createAccount(withEmail: email, password: password, completion)
                default:
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.getAccountInfo(uid: result!.user.uid, completion)
                }
            }
        }
    }
    
    func createAccount(withEmail email: String, password: String, _ completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("FBService - \(#function) encountered an error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else {
                DispatchQueue.main.async {
                    self.getAccountInfo(uid: result!.user.uid, completion)
                }
            }
        }
    }
    
    func getAccountInfo(uid: String, _ completion: @escaping (DocumentSnapshot?,Error?) -> Void) {
        let reference = FBService.userCollection.document(uid)
        reference.getDocument { (snapshot, error) in
            if let error = error {
                print("FBService - \(#function) encountered an error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let snapshot = snapshot {
                print("FBService - \(snapshot.data()), uid: \(uid)")
                if snapshot.exists {
                    DispatchQueue.main.async {
                        completion(snapshot, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, FBError.userInfoDoesntExist(uid: uid))
                    }
                }
            }
        }
    }
}
