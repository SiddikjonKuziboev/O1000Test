//
//  SavePostDM.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import Foundation
import RealmSwift


class SavePostDM: Object, Codable {
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    @objc dynamic var userId: Int
    
    override class func primaryKey() -> String? {
        "body"
    }
}

