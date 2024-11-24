//
//  UserDefaultsManager.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//

import Foundation

class UserDefaultsManager {
    // Function to save the liked status
    static func saveLikedStatus(for key: String, liked: Bool) {
        UserDefaults.standard.set(liked, forKey: key)
    }

    // Function to retrieve the liked status
    static func getLikedStatus(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}


