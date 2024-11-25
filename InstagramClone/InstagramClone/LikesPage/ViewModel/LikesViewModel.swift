//
//  LikesViewModel.swift
//  InstagramClone
//
//  Created by Giorgi Amiranashvili on 25.11.24.
//

import UIKit

class LikesViewModel {

    var posts = [Post]()
    var comments: [Comment] = []
    var categorizedPosts: [String: [Post]] = [:]
    var categorizedComments: [String: [Comment]] = [:]
    
    let dateFormatter = ISO8601DateFormatter()
    let networkManager = PostViewModel()
    
    func fetchDataAddPosts(completion: @escaping () -> Void) {
        networkManager.fetchPosts { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.posts = self.networkManager.posts
                for post in self.posts {
                    guard let currentComment = post.comments.data.first else { return }
                    self.comments.append(currentComment)
                }
                self.categorizePostsAndComments()
                completion()
            }
        }
    }
    
    func categorizeDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.isDateInToday(date) {
            let timeInterval = currentDate.timeIntervalSince(date)
            if timeInterval < 12000 {
                return "Now"
            }
        }
    
        if calendar.isDateInToday(date) {
            return "Today"
        }

        if calendar.isDate(date, equalTo: currentDate, toGranularity: .weekOfYear) {
            return "This Week"
        }

        if calendar.isDate(date, equalTo: currentDate, toGranularity: .month) {
            return "This Month"
        }
        return "Older"
    }

    func categorizePostsAndComments() {
        for post in posts {
            guard let formatedTime = dateFormatter.date(from: post.createdTime) else { return }
            let category = categorizeDate(formatedTime)
            if categorizedPosts[category] == nil {
                categorizedPosts[category] = []
            }
            categorizedPosts[category]?.append(post)
        }

        for comment in comments {
            guard let formatedComTime = dateFormatter.date(from: comment.createdTime) else { return }
            let category = categorizeDate(formatedComTime)
            if categorizedComments[category] == nil {
                categorizedComments[category] = []
            }
            categorizedComments[category]?.append(comment)
        }
    }

    func addingCommentToArray() {
        for post in posts {
            guard let currentComment = post.comments.data.first else { return }
            comments.append(currentComment)
        }
    }
    
    func parseDate(from isoString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: isoString)
    }
    
    func combinedDataForSection(_ section: String) -> [(isComment: Bool, data: Any)] {
        var combinedData: [(Bool, Any)] = []

        if let comments = categorizedComments[section] {
            combinedData.append(contentsOf: comments.map { (true, $0) })
        }

        if let posts = categorizedPosts[section] {
            combinedData.append(contentsOf: posts.map { (false, $0) })
        }
        return combinedData
    }
}

