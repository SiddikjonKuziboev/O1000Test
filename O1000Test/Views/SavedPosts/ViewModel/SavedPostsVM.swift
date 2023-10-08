//
//  SavedPostsVM.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import Foundation

class SavedPostsVM {
    
    let realm = RealmData.shared
    var posts: Box<[SavePostDM]> = Box([])
}

    
extension SavedPostsVM {
    
    func getData() {
        posts.value = RealmData.shared.fetchData()
    }
    
    func removeItem(indexPath: IndexPath) {
        realm.removeItem(item: posts.value[indexPath.row])
        posts.value.remove(at: indexPath.row)
    }
}


