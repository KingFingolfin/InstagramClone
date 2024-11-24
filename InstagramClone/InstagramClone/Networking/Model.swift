//
//  Model.swift
//  Assignmet27-InstagramClone
//
//  Created by Giorgi on 22.11.24.
//

import Foundation
 
struct APIResponse: Codable {
    let data: [Post]
    let meta: Meta
    let pagination: Pagination
}
 
struct Post: Codable {
    let attribution: String
    let caption: Caption
    let comments: Comments
    let createdTime: String
    let filter: String
    let id: String
    let images: Images
    let likes: Likes
    let link: String
    let location: Location
    let tags: [String]
    let type: String
    let user: User
    var userHasLiked: Bool
    let usersInPhoto: [TaggedUser]
    let videos: Videos
 
    enum CodingKeys: String, CodingKey {
        case attribution
        case caption
        case comments
        case createdTime = "created_time"
        case filter
        case id
        case images
        case likes
        case link
        case location
        case tags
        case type
        case user
        case userHasLiked = "user_has_liked"
        case usersInPhoto = "users_in_photo"
        case videos
    }
}
 
struct Caption: Codable {
    let createdTime: String
    let from: User
    let id: String
    let text: String
 
    enum CodingKeys: String, CodingKey {
        case createdTime = "created_time"
        case from
        case id
        case text
    }
}
 
struct Comments: Codable {
    let count: Int
    let data: [Comment]
}
 
struct Comment: Codable {
    let createdTime: String
    let from: User
    let id: String
    let text: String
 
    enum CodingKeys: String, CodingKey {
        case createdTime = "created_time"
        case from
        case id
        case text
    }
}
 
struct Images: Codable {
    let lowResolution: ImageDetails
    let standardResolution: ImageDetails
    let thumbnail: ImageDetails
 
    enum CodingKeys: String, CodingKey {
        case lowResolution = "low_resolution"
        case standardResolution = "standard_resolution"
        case thumbnail
    }
}
 
struct ImageDetails: Codable {
    let height: Int
    let url: String
    let width: Int
}
 
struct Likes: Codable {
    let count: Int
    let data: [User]
}
 
struct Location: Codable {
    let id: String
    let latitude: Double
    let longitude: Double
    let name: String
}
 
struct User: Codable {
    let fullName: String
    let id: String
    let profilePicture: String
    let username: String
 
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case id
        case profilePicture = "profile_picture"
        case username
    }
}
 
struct TaggedUser: Codable {
    let position: Position
    let user: User
}
 
struct Position: Codable {
    let x: Double
    let y: Double
}
 
struct Videos: Codable {
    let lowResolution: VideoDetails
    let standardResolution: VideoDetails
 
    enum CodingKeys: String, CodingKey {
        case lowResolution = "low_resolution"
        case standardResolution = "standard_resolution"
    }
}
 
struct VideoDetails: Codable {
    let height: Int
    let url: String
    let width: Int
}
 
struct Meta: Codable {
    let code: Int
}
 
struct Pagination: Codable {
    let nextMaxID: String
    let nextURL: String
 
    enum CodingKeys: String, CodingKey {
        case nextMaxID = "next_max_id"
        case nextURL = "next_url"
    }
}
 
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed
    case unexpectedStatusCode(Int)
}
