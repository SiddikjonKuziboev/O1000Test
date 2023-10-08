//
//  SavedPostsVC.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import UIKit

class SavedPostsVC: UIViewController {

    var tableView: UITableView!

    var viewModel = SavedPostsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Posts"
        setUpTableView()
        dataBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    
    private func dataBinding() {
                
        viewModel.posts.bind { _ in
            self.tableView.reloadData()
        }
    }
    
}


//MARK: TableView
extension SavedPostsVC: UITableViewDelegate, UITableViewDataSource {
    
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
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTVC", for: indexPath)as! PostsTVC
        
        let data = viewModel.posts.value[indexPath.row]
        cell.updateCellForSaved(post: data, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailVC()
        vc.viewModel.id = viewModel.posts.value[indexPath.row].userId
        navigationController?.pushViewController(vc, animated: true)
    }
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
  
            viewModel.removeItem(indexPath: indexPath)
        }
    }
    
}
