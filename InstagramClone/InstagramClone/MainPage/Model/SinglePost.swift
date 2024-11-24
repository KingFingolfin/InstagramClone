//
//  SinglePost.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//

import Foundation

struct SinglePost {
    let attribution: String
    let caption: String
    let createdTime: String
    let imageURL: String
    let likesCount: Int
    let location: String
    let user: User
    let commentsCount: Int
    let postLink: String
    let id: String
    
    init(from post: Post) {
        self.attribution = post.attribution
        self.caption = post.caption.text
        self.createdTime = post.createdTime
        self.imageURL = post.images.standardResolution.url
        self.likesCount = post.likes.count
        self.location = post.location.name
        self.user = post.user
        self.commentsCount = post.comments.count
        self.postLink = post.link
        self.id = post.id
    }
}
