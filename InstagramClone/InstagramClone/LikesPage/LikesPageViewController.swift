//
//  LikesPageViewController.swift
//  InstagramClone
//
//  Created by Giorgi on 22.11.24.
//

import UIKit
import Kingfisher

class LikesPageViewController: UIViewController {
    
    let viewModel = LikesViewModel()
    let networkManager = PostViewModel()
    
    let identifier = "LikesCell"
    
    let sectionTitles = ["Now", "Today", "This Week", "This Month"]
    
    let userTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableHeader()
        viewModel.fetchDataAddPosts { [weak self] in
            self?.userTableView.reloadData()
        }
    }
    
    func setupTableView() {
        view.backgroundColor = .grey
        
        view.addSubview(userTableView)
        userTableView.dataSource = self
        userTableView.delegate = self
        userTableView.register(LikesCell.self, forCellReuseIdentifier: identifier)
        
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            userTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableHeader() {
        let headerView = UIView()
        headerView.backgroundColor = .grey
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        
        let headerLabel = UILabel()
        headerLabel.text = "You"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = .black
        headerLabel.frame = headerView.bounds
        
        headerView.addSubview(headerLabel)
        userTableView.tableHeaderView = headerView
        
        let headerAppearance = UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
        headerAppearance.font = UIFont.boldSystemFont(ofSize: 15)
        headerAppearance.textColor = .black
    }
}

extension LikesPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return viewModel.combinedDataForSection(key).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LikesCell
        
        let key = sectionTitles[indexPath.section]
        let combinedData = viewModel.combinedDataForSection(key)
        let item = combinedData[indexPath.row]
        
        if item.isComment, let comment = item.data as? Comment {
            let username = comment.from.username
            let fullText = "\(username) commented your post"
            let attributedString = NSMutableAttributedString(string: fullText)
            
            if let usernameRange = fullText.range(of: username) {
                let nsRange = NSRange(usernameRange, in: fullText)
                let boldFont = UIFont.boldSystemFont(ofSize: 13)
                attributedString.addAttribute(.font, value: boldFont, range: nsRange)
            }
            
            cell.label.attributedText = attributedString
            let url = URL(string: comment.from.profilePicture)
            let urelSS = URL(string: viewModel.posts[indexPath.row].user.profilePicture)
            
            cell.userImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            cell.authorImageView.kf.setImage(with: urelSS)
            
            
        } else if let post = item.data as? Post {
            let username = post.likes.data.first?.username ?? "NO name Provided"
            let fullText = "\(username) liked your post"
            let attributedString = NSMutableAttributedString(string: fullText)
            
            if let usernameRange = fullText.range(of: username) {
                let nsRange = NSRange(usernameRange, in: fullText)
                let boldFont = UIFont.boldSystemFont(ofSize: 13)
                attributedString.addAttribute(.font, value: boldFont, range: nsRange)
            }
            
            cell.label.attributedText = attributedString
            let url = URL(string: post.user.profilePicture)
            let authorImage = post.likes.data.first?.profilePicture
            let authorImageUrl = URL(string: authorImage ?? "")
            cell.userImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            cell.authorImageView.kf.setImage(with: authorImageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
}
