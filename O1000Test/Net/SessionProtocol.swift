//
//  SessionProtocol.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import Foundation
protocol SessionProtocol {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
