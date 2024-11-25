import UIKit
 
class SearchViewController: UIViewController {
    private let viewModel = PhotoViewModel()
    private var filteredUser: User?
    private var isSearching = false
    let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by full name"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    let userInfoView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var collectionView: UICollectionView = {
          let layout = CustomInstagramLayout()
          let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collection.backgroundColor = .clear
          collection.translatesAutoresizingMaskIntoConstraints = false
          collection.register(SearchCollection.self, forCellWithReuseIdentifier: "SearchCollection")
          collection.delegate = self
          collection.dataSource = self
          return collection
      }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        searchBar.delegate = self
        fetchPhotos()
    }
    private func setupUI() {
        view.addSubview(horizontalStackView)
        view.addSubview(userInfoView)
        view.addSubview(collectionView)
        horizontalStackView.addArrangedSubview(searchBar)
        userInfoView.addSubview(userImageView)
        userInfoView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            userInfoView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 20),
            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userInfoView.heightAnchor.constraint(equalToConstant: 80),
            userImageView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor),
            userImageView.centerYAnchor.constraint(equalTo: userInfoView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 60),
            userImageView.heightAnchor.constraint(equalToConstant: 60),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            collectionView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    private func fetchPhotos() {
        viewModel.fetchPhotos { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    private func showUserInfo(_ user: User) {
        userInfoView.isHidden = false
        collectionView.isHidden = true
        userNameLabel.text = user.fullName
        if let profileImageUrl = URL(string: user.profilePicture) {
            loadImage(from: profileImageUrl, into: userImageView)
        }
    }
    private func resetView() {
        isSearching = false
        userInfoView.isHidden = true
        collectionView.isHidden = false
        collectionView.reloadData()
    }
}
 
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            resetView()
            return
        }
        isSearching = true
        viewModel.searchUser(by: searchText) { [weak self] user in
            DispatchQueue.main.async {
                self?.filteredUser = user
                if let user = user {
                    self?.showUserInfo(user)
                } else {
                    self?.resetView()
                }
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
 
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollection", for: indexPath) as? SearchCollection else {
            return UICollectionViewCell()
        }
        let photo = viewModel.photos[indexPath.item]
        if let imageUrl = URL(string: photo.url) {
            loadImage(from: imageUrl, into: cell.imageView)
        }
        return cell
    }
}
 
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
