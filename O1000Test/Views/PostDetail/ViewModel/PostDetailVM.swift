//
//  PostDetailVM.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import Foundation

class PostDetailsVM {
    
    let api = Net.shared
    var details: Box<[PostDetailDM]> = Box([])
    var id: Int!
}

extension PostDetailsVM {
    
    func getDetails() {
        api.fetchPostsDetails(id: id) { result in
            switch result {
            case .success(let details):

                DispatchQueue.main.async {
                    self.details.value = details
                }

            case .failure(let error):
                // Handle the error here
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

