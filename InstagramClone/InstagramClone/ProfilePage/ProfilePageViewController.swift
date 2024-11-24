//
//  ProfilePageViewController.swift
//  InstagramClone
//
//  Created by Giorgi on 22.11.24.
//

import UIKit
 
class ProfilePageViewController: UIViewController {
    
    private var posts: [Post] = []
    private var profileViewModel: PostViewModel = PostViewModel()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 48
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemSize = (screenWidth - 2) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupCollectionView()
        
        PostFetcher.fetchAndDisplayPosts(viewModel: profileViewModel) { [weak self] posts, fullName, profileImage in
            guard let self = self else { return }
            self.posts = posts
            self.nameLabel.text = fullName
            self.profileImageView.image = profileImage
            self.updateStatsUI()
            self.updateUI()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Profile"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statsStackView)
        contentView.addSubview(bioLabel)
        contentView.addSubview(editProfileButton)
        contentView.addSubview(collectionView)
        
        setupStatsStackView()
    }
    
    private func setupStatsStackView() {
        let postsLabel = createStatLabel(count: 0, label: "Posts")
        let followersLabel = createStatLabel(count: 124, label: "Followers")
        let followingLabel = createStatLabel(count: 221, label: "Following")
        
        [postsLabel, followersLabel, followingLabel].forEach {
            statsStackView.addArrangedSubview($0)
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -60),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentViewHeightConstraint,
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 88),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 96),
            profileImageView.heightAnchor.constraint(equalToConstant: 96),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            
            statsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 118),
            statsStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 28),
            statsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            editProfileButton.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 20),
            editProfileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            editProfileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editProfileButton.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func createStatLabel(count: Int, label: String) -> UILabel {
        let statLabel = UILabel()
        statLabel.font = UIFont.systemFont(ofSize: 14)
        statLabel.text = "\(count)\n\(label)"
        statLabel.textAlignment = .center
        statLabel.numberOfLines = 2
        return statLabel
    }
    
    private func updateUI() {
        collectionView.reloadData()
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 2) / 3
        let numberOfItems = CGFloat(posts.count)
        let numberOfRows = ceil(numberOfItems / 3)
        let collectionViewHeight = numberOfRows * itemWidth + (numberOfRows - 1)
        
        if let heightConstraint = collectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.isActive = false
        }
        
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
        
        view.layoutIfNeeded()
    }
    
    private func updateStatsUI() {
        if let postsLabel = statsStackView.arrangedSubviews.first as? UILabel {
            postsLabel.text = "\(posts.count)\nPosts"
        }
    }
}
 
extension ProfilePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as? PostCell else {
            return UICollectionViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
 
