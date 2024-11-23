//
//  PostCell.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 23.11.24.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    var post: SinglePost?
    var isLiked: Bool = false
    // MARK: - UI Elements
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views and Constraints
    
    private func setupViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(timestampLabel)
        
        // Add Constraints
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            
            locationLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            
            postImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            likeButton.widthAnchor.constraint(equalToConstant: 24),
            likeButton.heightAnchor.constraint(equalToConstant: 24),
            
            commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 12),
            
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 12),
            
            likeCountLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 8),
            likeCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            captionLabel.topAnchor.constraint(equalTo: likeCountLabel.bottomAnchor, constant: 4),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            timestampLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 4),
            timestampLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    // MARK: - Helper Methods
    
    private func formatTimestamp(_ timestamp: String) -> String {
        // Converts the timestamp to a more readable format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  // Adjust format if necessary
        if let date = dateFormatter.date(from: timestamp) {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: date)
        }
        return timestamp
    }
    
    func configure(with post: Post) {
        // Set profile image
        if let profileImageUrl = URL(string: post.user.profilePicture) {
            profileImageView.loadImage(from: profileImageUrl)
        }
        
        // Set the username and location
        usernameLabel.text = post.user.username
        locationLabel.text = post.location.name
        
        // Set the post image
        if let postImageUrl = URL(string: post.images.standardResolution.url) {
            postImageView.loadImage(from: postImageUrl)
        }
        
        // Set like count, caption, and timestamp
        likeCountLabel.text = "\(post.likes.count) likes"
        captionLabel.text = post.caption.text
        timestampLabel.text = formatTimestamp(post.createdTime)
        
        // Load the saved liked status from UserDefaults and update the like button
        isLiked = UserDefaultsManager.getLikedStatus(for: post.id)
        updateLikeButtonImage() // Update the button image based on the liked status
    }

    
    private func updateLikeButtonImage() {
        let heartIconName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: heartIconName), for: .normal)
    }
    
    // MARK: - Button Actions
    private func setupButtonActions() {
        likeButton.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(handleCommentButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
    }
    
    @objc private func handleLikeButton() {
        // Toggle the local liked status
        isLiked.toggle()

        // Update the heart icon based on the new liked status
        updateLikeButtonImage()

        // Check if post.id is not nil
        if let postID = post?.id {
            // Save the updated liked status in UserDefaults
            UserDefaultsManager.saveLikedStatus(for: postID, liked: isLiked)
            print("Successfully saved in Userdata")
            // Send API request to update the liked status on the server
            APIManager.shared.updateLikeStatusOnServer(postID: postID, liked: isLiked) { success in
                if success {
                    print("Successfully updated like status on the server")
                } else {
                    print("Failed to update like status on the server")
                    // Optionally, you can revert the change in case the server request fails
                    self.isLiked.toggle() // Revert the liked status
                    self.updateLikeButtonImage() // Update the button icon back
                }
            }
        } else {
            print("Post object: \(String(describing: post))")
            print("Post ID: \(String(describing: post?.id))")
            
            // Optionally, you can handle the error here (e.g., showing an alert to the user)
        }
    }



    
    @objc private func handleCommentButton() {
        print("[⚠️] Comment button pressed")
    }
    
    @objc private func handleShareButton() {
        print("[⚠️] Share button pressed")
    }
}
