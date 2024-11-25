//
//  APIManager.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//
import Foundation

class APIManager {
    static let shared = APIManager()

    func updateLikeStatusOnServer(postID: String, liked: Bool, completion: @escaping (Bool) -> Void) {
        let params: [String: Any] = [
            "postID": postID,
            "liked": liked
        ]
        NetworkManager.shared.performAPIRequest(endpoint: "/likeStatus", parameters: params) { success in
            completion(success)
        }
    }
}


