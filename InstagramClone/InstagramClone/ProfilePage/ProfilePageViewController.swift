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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 48
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Bio description goes here"
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
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemSize = (screenWidth - 3) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statsStackView)
        contentView.addSubview(bioLabel)
        contentView.addSubview(editProfileButton)
        contentView.addSubview(collectionView)
        
        let postsLabel = createStatLabel(count: 0, label: "Posts")
        let followersLabel = createStatLabel(count: 0, label: "Followers")
        let followingLabel = createStatLabel(count: 0, label: "Following")
        
        statsStackView.addArrangedSubview(postsLabel)
        statsStackView.addArrangedSubview(followersLabel)
        statsStackView.addArrangedSubview(followingLabel)
        fetchAndDisplayPosts()
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -80),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 88),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 96),
            profileImageView.heightAnchor.constraint(equalToConstant: 96),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),

            statsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 118),
            statsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 142),
            statsStackView.widthAnchor.constraint(equalToConstant: 255),
            statsStackView.heightAnchor.constraint(equalToConstant: 36),

            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            editProfileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 260),
            editProfileButton.widthAnchor.constraint(equalToConstant: 343),
            editProfileButton.heightAnchor.constraint(equalToConstant: 29),
            editProfileButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 1000),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
         ])

        collectionView.dataSource = self
    }
    func downloadImage(fromurl: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: fromurl) { data, _ , error in guard let data = data, error == nil else {
    print("Failed to download image: \(String(describing: error))")
                    completion(nil)
    return
                }
                completion(UIImage(data: data))
            }
            task.resume()
        }


    private func fetchAndDisplayPosts() {
        profileViewModel.fetchPosts { [weak self] in
                guard let self else {return}
                DispatchQueue.main.async {
                    self.nameLabel.text = self.profileViewModel.posts.last?.user.fullName ?? "GEO"
                    if let url = URL(string: self.profileViewModel.posts.last?.user.profilePicture ?? "geo") {
                        self.downloadImage(fromurl: url) { image in DispatchQueue.main.async {
                            self.profileImageView.image = image
                                    }
                                }
                            }
                    self.nameLabel.text = self.profileViewModel.posts.last?.user.fullName ?? "GEO"
                    self.nameLabel.text = self.profileViewModel.posts.last?.user.fullName ?? "GEO"
                    self.nameLabel.text = self.profileViewModel.posts.last?.user.fullName ?? "GEO"

                }
            }
        }

    private func updateUI() {
        collectionView.reloadData()
    }

    private func handleError(_ error: NetworkError) {
        print("Error fetching posts: \(error)")
    }

    private func createStatLabel(count: Int, label: String) -> UILabel {
        let statLabel = UILabel()
        statLabel.font = UIFont.boldSystemFont(ofSize: 14)
        statLabel.text = "\(count)\n\(label)"
        statLabel.textAlignment = .center
        statLabel.numberOfLines = 2
        statLabel.translatesAutoresizingMaskIntoConstraints = false
        return statLabel
    }
}
extension ProfilePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileViewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let post = profileViewModel.posts[indexPath.row]
        return cell
    }
}
