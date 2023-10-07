//
//  URl.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import Foundation
extension URL {
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        guard let queryItems = components.queryItems else { return nil }
        
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    
}

