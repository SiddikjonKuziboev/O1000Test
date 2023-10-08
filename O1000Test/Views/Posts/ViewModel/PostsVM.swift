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
    
}

extension PostsVM {
    
    func getPosts() {
        
        api.fetchDataFromAPI { result in
            switch result {
            case .success(let posts):
                // Handle the fetched posts here
                print(posts)
                DispatchQueue.main.async {
                    self.posts.value = posts
                }

            case .failure(let error):
                // Handle the error here
                print("Error: \(error.localizedDescription)")
            }
        }

    }
    
    
    
   
    
}
    
