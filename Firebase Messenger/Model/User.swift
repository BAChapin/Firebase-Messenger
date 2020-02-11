//
//  User.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/11/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import Foundation
import Firebase

class User {
    private var reference: DocumentReference?
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    
    var dict: [String : Any] {
        return [Key.firstName.rawValue : firstName,
                Key.lastName.rawValue : lastName,
                Key.email.rawValue : email]
    }

    enum Key: String {
        case firstName
        case lastName
        case email
    }
    
    init(uid: String) {
        self.uid = uid
        firstName = ""
        lastName = ""
        email = ""
    }
    
    init(_ dict: [String : Any]) {
        firstName = dict[Key.firstName.rawValue] as! String
        lastName = dict[Key.lastName.rawValue] as! String
        email = dict[Key.email.rawValue] as! String
        uid = ""
    }
    
    convenience init?(snapshot: DocumentSnapshot) {
        guard let dict = snapshot.data() else { return nil }
        self.init(dict)
        reference = snapshot.reference
        uid = snapshot.documentID
    }
    
    func initializeUserEntry(_ completion: @escaping (Bool, Error?) -> Void) {
        let reference = FBService.userCollection.document(uid)
        reference.setData(dict) { (error) in
            if let error = error {
                print("User - \(#function) encountered an error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false, error)
                }
            } else {
                DispatchQueue.main.async {
                    self.reference = reference
                    completion(true, nil)
                }
            }
        }
        
    }
    
}
