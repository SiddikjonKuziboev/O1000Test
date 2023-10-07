//
//  Ext+URLRequest.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import Foundation
extension URLRequest {
    // MARK: - JSON
    mutating func setJSONParameters(_ parameters: [String: Any]?) {
        guard let parameters = parameters else {
            httpBody = nil
            return
        }
        
        httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions(rawValue: 0))
    }
}
