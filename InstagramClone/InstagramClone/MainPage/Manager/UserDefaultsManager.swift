//
//  UserDefaultsManager.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//

import Foundation

class UserDefaultsManager {
    static func saveLikedStatus(for key: String, liked: Bool) {
        UserDefaults.standard.set(liked, forKey: key)
    }
    static func getLikedStatus(for key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}


