//
//  RealmData.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import RealmSwift
import Foundation


class RealmData {
    
    static var shared = RealmData()
    var realm : Realm!
    
    init() {
        realm = try! Realm()
//        print(realm.configuration.fileURL,"fileurl")
    }
    
    func saveIteams(data: SavePostDM){
        try! realm.write({
            realm.add(data, update: .modified)
        })
    }
    
    func removeItem(item: SavePostDM) {
        try! realm.write {
            realm.delete(item)
        }
    }
    
    func fetchData()-> [SavePostDM] {
        realm.objects(SavePostDM.self).compactMap{$0}
        }
    
    
   
    
}
