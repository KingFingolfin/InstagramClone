//
//  LikesCell.swift
//  InstagramClone
//
//  Created by Giorgi Amiranashvili on 25.11.24.
//

import UIKit
import Kingfisher

class LikesCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    private func configureUI() {
        contentView.addSubview(label)
        contentView.addSubview(userImageView)
        contentView.addSubview(authorImageView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        authorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 230),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 44),
            userImageView.heightAnchor.constraint(equalToConstant: 44),
            userImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            authorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            authorImageView.widthAnchor.constraint(equalToConstant: 44),
            authorImageView.heightAnchor.constraint(equalToConstant: 44),
            authorImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}
