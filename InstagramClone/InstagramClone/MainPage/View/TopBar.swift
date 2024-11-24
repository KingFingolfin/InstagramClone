//
//  TopBar.swift
//  InstagramClone
//
//  Created by Nino Kurshavishvili on 24.11.24.
//

import UIKit

class TopBar: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "InstagramLogo") // Replace with your asset name
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white // Set the background color if needed
        addSubview(logoImageView)
        
        // Center the logo in the TopBar
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 40), // Adjust logo size as needed
            logoImageView.widthAnchor.constraint(equalToConstant: 120)  // Adjust logo size as needed
        ])
    }
}
