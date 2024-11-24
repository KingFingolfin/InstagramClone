//
//  APIManager.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//
import Foundation

class APIManager {
    static let shared = APIManager()

    // Use NetworkManager to perform the API request
    func updateLikeStatusOnServer(postID: String, liked: Bool, completion: @escaping (Bool) -> Void) {
        // Prepare the parameters for the API request
        let params: [String: Any] = [
            "postID": postID,
            "liked": liked
        ]
        
        // Perform the request through NetworkManager
        NetworkManager.shared.performAPIRequest(endpoint: "/likeStatus", parameters: params) { success in
            completion(success)
        }
    }
}


