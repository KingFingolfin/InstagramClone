//
//  TabBarViewController.swift
//  InstagramClone
//
//  Created by Giorgi on 22.11.24.
//
 
import UIKit
 
class TabBarViewController: UITabBarController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "TabBarProfileImage")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0
        return imageView
    }()
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        customizeTabBarAppearance()
        self.delegate = self
 
    }
    private func updateProfileImageBorder(selected: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.profileImageView.layer.borderWidth = selected ? 1 : 0
        }
    }
 
 
 
    private func setupTabBar() {
        let mainPageVC = MainPageViewController()
        mainPageVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "homeIconOutline"),
            selectedImage: UIImage(named: "homeIcon")
        )
 
        let searchPageVC = SearchViewController()
        searchPageVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "searchIcon"),
            selectedImage: UIImage(named: "searchIconBold")
        )
 
        let createPostVC = StoryPageViewController()
        createPostVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "plusIcon"),
            selectedImage: UIImage(named: "plusIcon")
        )
 
        let likesPageVC = LikesPageViewController()
        likesPageVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "likesIcon"),
            selectedImage: UIImage(named: "heartFill")
        )
 
        let profilePageVC = ProfilePageViewController()
                profilePageVC.delegate = self
                profilePageVC.tabBarItem = UITabBarItem(
                    title: nil,
                    image: nil,
                    selectedImage: nil
                )
 
        self.viewControllers = [mainPageVC, searchPageVC, createPostVC, likesPageVC, profilePageVC]
        
        tabBar.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor, constant: tabBar.frame.width / 5 * 2),
            profileImageView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 6)
        ])
 
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                if index == 4 {
                    item.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
                } else {
                    item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
                }
            }
        }
 
        tabBar.tintColor = UIColor(hex: "262626")
        tabBar.unselectedItemTintColor = UIColor(hex: "262626")
    }
 
    private func customizeTabBarAppearance() {
        tabBar.backgroundColor = UIColor(hex: "FAFAFA")
        
        let divider = UIView(frame: CGRect(x: 0, y: -2, width: tabBar.bounds.width, height: 0.5))
        divider.backgroundColor = UIColor(hex: "000000").withAlphaComponent(0.1)
        tabBar.addSubview(divider)
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 79
        tabBarFrame.origin.y = view.frame.height - 79
        tabBar.frame = tabBarFrame
        
        let profileItemX = tabBar.frame.width / 5 * 4
        profileImageView.center.x = profileItemX + (tabBar.frame.width / 10)
    }
    
    func updateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
}
 
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
 
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
 
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
 
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
 
extension TabBarViewController: ProfilePageViewControllerDelegate {
    func didUpdateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
}
 
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let isProfileSelected = tabBarController.selectedIndex == 4
        updateProfileImageBorder(selected: isProfileSelected)
    }
}
