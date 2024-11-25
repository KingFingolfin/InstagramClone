//
//  PostCell1.swift
//  INSTAGRAM
//
//  Created by shota shotadze on 24.11.24.
//

import UIKit
class PostCell1: UICollectionViewCell {
    static let identifier = "PostCell1"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        if let imageUrl = URL(string: post.images.standardResolution.url) {
            downloadImage(fromurl: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
    
    private func downloadImage(fromurl: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: fromurl) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to download image: \(String(describing: error))")
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        task.resume()
    }
}
