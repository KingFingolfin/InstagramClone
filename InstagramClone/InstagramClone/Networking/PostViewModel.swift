//
//  ViewModel.swift
//  Assignmet27-InstagramClone
//
//  Created by Giorgi on 22.11.24.
//

import Foundation

final class PostViewModel {
    var posts: [Post] = []
    
    func fetchPosts(completionHandler: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let fetchedPosts):
                self?.posts = fetchedPosts
                completionHandler()
            case .failure(let error):
                print("Failed to fetch posts: \(error.localizedDescription)")
                completionHandler()
            }
        }
    }
}

