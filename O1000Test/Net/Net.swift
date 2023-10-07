//
//  Net.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import UIKit

//struct Net {
//
//    private init() {}
//
//    static let shared = Net()
//
//    internal var session: SessionProtocol = URLSession.shared
//
//    private let isEnableDebug = true
//
//    typealias JSONTaskCompletionHandler = (Result<Data>) -> ()
//
//
//    func jsonTask(url: EndPoints, requestMethod: HTTPRequestMethod, headers: [String : String]? = nil, parameters: [String : Any]? = nil, completionHandler completion: @escaping JSONTaskCompletionHandler) {
//
//        var components = URLComponents()
//        components.scheme = BaseURL.scheme.rawValue
//        components.host   = BaseURL.host.rawValue
//        components.path   = BaseURL.path.rawValue + url.rawValue
//        // Set QueryItems
//        if requestMethod == .get {
//            components.setQueryParameters(parameters)
//        }
//
//        guard let url = components.url else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = requestMethod.rawValue
//
//        // Set Headers
//        request.addValue(Headers.applicationJson, forHTTPHeaderField: Headers.contentType)
//        headers?.forEach{request.addValue($0.value, forHTTPHeaderField: $0.key)}
//
//        // Set Params
//        if requestMethod == .post {
//            request.setJSONParameters(parameters)
//        }
//
//        DispatchQueue.global(qos: .background).async {
//            self.session.dataTask(with: request) { (data, response, error) in
//                DispatchQueue.main.async {
//                    guard let httpResponse = response as? HTTPURLResponse else {
//                        completion(.Error(.requestFailed))
//                        return
//                    }
//
//                    guard error == nil else {
//                        completion(.Error(.responseUnsuccessful))
//                        return
//                    }
//
//                    guard let data = data else {
//                        completion(.Error(.invalidData))
//                        return
//                    }
//
//                    if isEnableDebug {
//                        print("\n--- Start debug ---")
//                        print("URL: \(url)")
//                        print("Headers: \(String(describing: request.allHTTPHeaderFields))")
//                        print("Parameters: \(String(describing: parameters))")
//                        print("HTTPMethod: \(String(describing: request.httpMethod))")
//                        print("Status Code: \(httpResponse.statusCode)")
//                    }
//
//                    do {
//                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
//                        if isEnableDebug {
//                            print("Result: \(String(describing: jsonResult))")
//                        }
//
//                        switch httpResponse.statusCode {
//                        case 200, 202:
//                            completion(.Success(data))
//                        case 401:
//                            completion(.Error(.notAuthorized))
//                        case 402, 409:
//                            completion(.Success(data))
//                        case 500:
//                            completion(.Error(.serverError))
//                        default:
//                            completion(.Error(.fromMessage, jsonResult?["message"] as? String))
//                        }
//                    } catch {
//                        completion(.Error(.responseUnsuccessful))
//                    }
//
//                    if isEnableDebug {
//                        print("--- End debug ---\n")
//                    }
//                }
//            }.resume()
//        }
//    }
//}
//
//extension Net {
//
//    //MARK: Base URL
//   private enum BaseURL: String {
//        case scheme = "https"
//        case host = "jsonplaceholder.typicode.com"
//        case path = "/api"
//       //https://jsonplaceholder.typicode.com/
//    }
//
//   private struct Headers {
//        static let contentType = "Content-Type"
//        static let applicationJson = "application/json"
//       static let language = "accept-language"
//    }
//
//     enum Result<T> {
//        case Success(T)
//        case Error(APIError, String? = nil)
//    }
//
//
//}
//
//struct JSONData<T: Decodable>: Decodable {
////    let success: Bool
////    let error: String?
//    let data: T?
//}
//
//
//struct Meta: Codable {
//    let itemsPerPage: Int?
//    let totalItems: Int?
//    let currentPage: Int?
//    let totalPages: Int?
//}
//
//enum APIError: Error {
//    case requestFailed
//    case invalidData
//    case responseUnsuccessful
//    case serverError
//    case notAuthorized
//    case fromMessage
//    case notEnoughBalance
//}
//

struct Net {
    
    static let shared = Net()
    
    let baseURL = "https://jsonplaceholder.typicode.com"
    //MARK: POSTS
    func fetchDataFromAPI(completion: @escaping (Result<[PostsDM], Error>) -> Void) {
        
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

}


