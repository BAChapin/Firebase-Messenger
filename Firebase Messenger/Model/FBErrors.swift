//
//  FBErrors.swift
//  Firebase Messenger
//
//  Created by Brett Chapin on 2/11/20.
//  Copyright © 2020 Black Rose Productions. All rights reserved.
//

import Foundation

enum FBError: Error {
    case userInfoDoesntExist(uid: String)
    
    var localizedDescription: String {
        switch self {
        case .userInfoDoesntExist: return "The user's information doesn't exist."
        }
    }
    
    var ammendment: String? {
        switch self {
        case .userInfoDoesntExist(let uid) : return uid
        }
    }
}
