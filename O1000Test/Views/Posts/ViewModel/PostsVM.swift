//
//  PostsVM.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import Foundation

class PostsVM {
    
    let api = Net.shared
    var posts: Box<[PostsDM]> = Box([])
    var filteredPosts: Box<[PostsDM]> = Box([])
    
}

extension PostsVM {
    
    func getPosts() {
        
        api.fetchPostsData { result in
            switch result {
            case .success(let posts):

                DispatchQueue.main.async {
                    self.posts.value = posts
                }

            case .failure(let error):

                print("Error: \(error.localizedDescription)")
            }
        }

    }
    
    
    func filter(for searchText: String) {
        filteredPosts.value = searchText.isEmpty ? posts.value : posts.value.filter { $0.title.contains(searchText.lowercased()) }
        
    }
    
    
}
    
