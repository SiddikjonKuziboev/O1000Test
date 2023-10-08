//
//  PostDetailDM.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 08/10/23.
//

import Foundation

struct PostDetailDM: Codable {
    
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: AddressDM
    var phone: String
    var website: String
    var company: CompanyDM
    
    struct AddressDM: Codable {
        var street: String
        var suite: String
        var city: String
        var zipcode: String
        var geo: GeoDM
        
        struct GeoDM: Codable {
            var lat: String
            var lng: String
        }
    }
    
    struct CompanyDM: Codable {
        
        var name: String
        var catchPhrase: String
        var bs: String
    }
}
