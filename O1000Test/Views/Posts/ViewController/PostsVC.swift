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
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    let viewModel = PostsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Posts"
        setUpTableView()
        setUpRefreshControl()
        setUpSearchBar()
        dataBinding()
    }
    
    
    private func dataBinding() {
        
        viewModel.getPosts()

        viewModel.posts.bind { _ in
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
        
        viewModel.filteredPosts.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    //MARK: Action
    @objc func refresh() {
        viewModel.getPosts()
    }
    
}

//MARK: SeachBar
extension PostsVC: UISearchResultsUpdating {
    
    private func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Posts"
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewModel.filter(for: searchText)
    }
    
}

//MARK: TableView
extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostsTVC.self, forCellReuseIdentifier: "PostsTVC")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setUpRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? viewModel.filteredPosts.value.count : viewModel.posts.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTVC", for: indexPath)as! PostsTVC
        
        let data = isSearching ? viewModel.filteredPosts.value[indexPath.row] : viewModel.posts.value[indexPath.row]
        cell.updateCell(post: data, indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailVC()
        vc.viewModel.id = isSearching ? viewModel.filteredPosts.value[indexPath.row].userId : viewModel.posts.value[indexPath.row].userId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: Save Post
extension PostsVC: PostsTVCDelegate {
    
    func setStar(index: IndexPath) {
        let data =  isSearching ? viewModel.filteredPosts.value[index.row] : viewModel.posts.value[index.row]
        
        let savePostData = SavePostDM()
        savePostData.body = data.body
        savePostData.title = data.title
        savePostData.userId = data.userId
        RealmData.shared.saveIteams(data: savePostData)
    }
}
