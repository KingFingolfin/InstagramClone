//
//  PhotoViewModel.swift
//  Instagram
//
//  Created by Imac on 23.11.24.
//
 
import Foundation
 
final class PhotoViewModel {
    var photos: [ImageDetails] = []
    private var users: [User] = []
    func fetchPhotos(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let posts):
                self?.photos = posts.compactMap { $0.images.standardResolution }
                self?.users = posts.map { $0.user }
                completion()
            case .failure(let error):
                print("Failed to fetch photos: \(error)")
                completion()
            }
        }
    }
    func searchUser(by name: String, completion: @escaping (User?) -> Void) {
        let filteredUser = users.first { user in
            user.fullName.lowercased().contains(name.lowercased())
        }
        completion(filteredUser)
    }
}
