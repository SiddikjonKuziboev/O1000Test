//
//  Ext+URLComponents.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import Foundation
extension URLComponents {
    // MARK: - QueryItems
    mutating func setQueryParameters(_ parameters: [String: Any]?) {
        if let parameters = parameters, !parameters.isEmpty {
            queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems!.append(queryItem)
            }
        }
    }
}
