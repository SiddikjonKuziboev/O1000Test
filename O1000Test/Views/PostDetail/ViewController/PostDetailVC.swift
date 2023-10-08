//
//  PostDetailVC.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//


import UIKit

class PostDetailVC: UIViewController {

    var tableView: UITableView!

    let viewModel = PostDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       setUpTableView()
        dataBinding()
    }
    
    private func dataBinding() {
        
        viewModel.getDetails()
        viewModel.details.bind { _ in
            self.tableView.reloadData()
        }
       
    }
}

//MARK: TableView
extension PostDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostDetailTVC.self, forCellReuseIdentifier: "PostDetailTVC")
        
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
        return viewModel.details.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTVC", for: indexPath)as! PostDetailTVC
        
        let data = viewModel.details.value[indexPath.row]
        cell.updateCell(user: data)
        return cell
    }

 
    
}
