//
//  StoryPageViewController.swift
//  InstagramClone
//
//  Created by Giorgi on 25.11.24.
//

import UIKit

class StoryPageViewController: UIViewController {
    private let mainLabel = UILabel()
    private let smallText = UILabel()
    private let settingsLink = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        labelSetup()
    }
    
    private func labelSetup() {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(smallText)
        smallText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsLink)
        settingsLink.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel.text = "Please Allow Access to your Photos"
        smallText.text = "This allows Instagram to share photos from your library and save photos to your camera roll."
        settingsLink.text = "Enable Library Access"
        
        mainLabel.textColor = .white
        smallText.textColor = .gray
        settingsLink.textColor = .cyan
        smallText.numberOfLines = 0
        smallText.lineBreakMode = .byWordWrapping
        smallText.textAlignment = .center
        
        mainLabel.font = UIFont.systemFont(ofSize: 24)
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90),
            smallText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            smallText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            settingsLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsLink.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
}

#Preview {
    StoryPageViewController()
}
