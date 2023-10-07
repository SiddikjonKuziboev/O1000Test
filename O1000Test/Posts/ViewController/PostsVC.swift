//
//  PostsVC.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import UIKit

class PostsVC: UIViewController {
    
    
    var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    let viewModel = PostsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpTableView()
        setUpRefreshControl()
        dataBinding()
    }
    
    private func setUpRefreshControl() {

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func dataBinding() {
        
        viewModel.getPosts()
        
        viewModel.posts.bind { _ in
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: Action
    @objc func refresh() {
        viewModel.getPosts()
    }
    
}

extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "poststvc")
        let data = viewModel.posts.value[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = data.title
        content.secondaryText = data.body
        cell.contentConfiguration = content
        return cell
    }
}
