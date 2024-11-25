//
//  MainPageViewController.swift
//  InstagramClone
//
//  Created by Giorgi on 22.11.24.
//
import UIKit
 
class MainPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PostCellDelegate {
 
    private let postViewModel = PostViewModel()
    private var posts: [Post] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        fetchData()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchData() {
        postViewModel.fetchPosts { [weak self] in
            DispatchQueue.main.async {
                self?.posts = self?.postViewModel.posts ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.delegate = self
 
        return cell
    }
    
    func didUpdateLikeStatus(for cell: PostCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            posts[indexPath.row].userHasLiked = cell.isLiked
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 0
        return CGSize(width: width, height: 700)
    }
}
 
class MainPageViewController_Previews: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainPageVC = MainPageViewController()

        addChild(mainPageVC)
        view.addSubview(mainPageVC.view)
        mainPageVC.didMove(toParent: self)

        mainPageVC.view.frame = view.bounds
    }
}
 
