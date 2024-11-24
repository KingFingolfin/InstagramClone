//
//  ShareBottomSheetViewController.swift
//  InstagramClone
//
//  Created by Tiko on 23.11.24.
//

import UIKit

class ShareBottomSheetViewController: UIViewController {

    private let profileNames = ["Alex", "Bella", "Chris", "Diana", "Evan", "Fiona"]
    private let profileImages: [UIImage?] = [
        UIImage(systemName: "person.circle"),
        UIImage(systemName: "person.circle.fill"),
        UIImage(systemName: "person.circle"),
        UIImage(systemName: "person.circle.fill"),
        UIImage(systemName: "person.circle"),
        UIImage(systemName: "person.circle.fill")
    ]

    private let actionTitles = ["Copy Link", "Share to...", "WhatsApp", "Add to Story"]
    private let actionIcons: [UIImage?] = [
        UIImage(systemName: "link"),
        UIImage(systemName: "square.and.arrow.up"),
        UIImage(systemName: "message"),
        UIImage(systemName: "plus")
    ]

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let actionStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true

        let screenHeight = UIScreen.main.bounds.height
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: screenHeight * 0.5)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])

        actionStackView.axis = .horizontal
        actionStackView.distribution = .fillEqually
        actionStackView.spacing = 16
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionStackView)

        for (index, title) in actionTitles.enumerated() {
            let actionButton = UIButton(type: .system)
            actionButton.setTitle(title, for: .normal)
            actionButton.setImage(actionIcons[index], for: .normal)
            actionButton.tintColor = .black
            actionButton.setTitleColor(.black, for: .normal)
            actionButton.contentHorizontalAlignment = .center
            actionButton.titleEdgeInsets = UIEdgeInsets(top: 32, left: -32, bottom: 0, right: 0)
            actionButton.imageEdgeInsets = UIEdgeInsets(top: -8, left: 0, bottom: 16, right: 0)
            actionStackView.addArrangedSubview(actionButton)
        }

        NSLayoutConstraint.activate([
            actionStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            actionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionStackView.heightAnchor.constraint(equalToConstant: 80),
            actionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
}

extension ShareBottomSheetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.configure(image: profileImages[indexPath.item], name: profileNames[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 3
        return CGSize(width: width, height: width + 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

class ProfileCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(image: UIImage?, name: String) {
        imageView.image = image
        nameLabel.text = name
    }
}
