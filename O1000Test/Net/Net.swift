//
//  Net.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import UIKit

struct Net {
    
    static let shared = Net()
    
    let baseURL = "https://jsonplaceholder.typicode.com"
    //MARK: POSTS
    func fetchPostsData(completion: @escaping (Result<[PostsDM], Error>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)\(EndPoints.posts.rawValue)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        
        let session = URLSession.shared

        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }


            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP request failed"])))
                return
            }

            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([PostsDM].self, from: data!)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }

        
        task.resume()
    }
    
    //MARK: Post details
    func fetchPostsDetails(id: Int,completion: @escaping (Result<[PostDetailDM], Error>) -> Void) {
   
        guard var components = URLComponents(string: "\(baseURL)\(EndPoints.users.rawValue)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let userIdQueryItem = URLQueryItem(name: "userId", value: "\(id)")
        components.queryItems = [userIdQueryItem]
      
        guard let url = components.url else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let session = URLSession.shared
        
        

        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }


            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP request failed"])))
                return
            }

            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode([PostDetailDM].self, from: data!)
                completion(.success(details))
            } catch {
                completion(.failure(error))
            }
        }

        
        task.resume()
    }


}


