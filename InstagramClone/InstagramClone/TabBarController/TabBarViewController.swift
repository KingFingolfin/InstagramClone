//
//  TabBarViewController.swift
//  InstagramClone
//
//  Created by Giorgi on 22.11.24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        customizeTabBarAppearance()
    }

    private func setupTabBar() {

        let mainPageVC = UIViewController()
        mainPageVC.view.backgroundColor = .white
        mainPageVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "homeIcon"), selectedImage: UIImage(named: "homeIcon"))

        let searchPageVC = UIViewController()
        searchPageVC.view.backgroundColor = .lightGray
        searchPageVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "searchIcon"), selectedImage: UIImage(named: "searchIcon"))

        let createPostVC = UIViewController()
        createPostVC.view.backgroundColor = .cyan
        createPostVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "plusIcon"), selectedImage: UIImage(named: "plusIcon"))

        let likesPageVC = UIViewController()
        likesPageVC.view.backgroundColor = .yellow
        likesPageVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "likesIcon"), selectedImage: UIImage(named: "likesIcon"))

        let profilePageVC = UIViewController()
        profilePageVC.view.backgroundColor = .purple
        profilePageVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person.crop.circle")?.withTintColor(UIColor.systemPink, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")?.withTintColor(UIColor.systemTeal, renderingMode: .alwaysOriginal)
        )


        self.viewControllers = [mainPageVC, searchPageVC, createPostVC, likesPageVC, profilePageVC]


        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
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
