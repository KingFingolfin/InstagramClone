//
//  File.swift
//  INSTAGRAM
//
//  Created by shota shotadze on 24.11.24.
//
import UIKit

class PostFetcher {
    static func fetchAndDisplayPosts(
        viewModel: PostViewModel,
        onCompletion: @escaping ([Post], String?, UIImage?) -> Void
    ) {
        viewModel.fetchPosts {
            DispatchQueue.main.async {
                let posts = viewModel.posts
                var fullName: String? = nil
                var profileImage: UIImage? = nil
                
                if let user = posts.first?.user {
                    fullName = user.fullName
                    if let url = URL(string: user.profilePicture) {
                        downloadImage(from: url) { image in
                            DispatchQueue.main.async {
                                profileImage = image
                                onCompletion(posts, fullName, profileImage)
                            }
                        }
                    } else {
                        onCompletion(posts, fullName, nil)
                    }
                } else {
                    onCompletion(posts, nil, nil)
                }
            }
        }
    }
    
    private static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to download image: \(String(describing: error))")
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        task.resume()
    }
}
