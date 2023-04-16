//
//  Requestable.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

protocol Requestable {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: ParameterType { get }
    var header: [String: String]? { get }
    func toURLRequest() -> URLRequest
    
}

extension Requestable {
    
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:5000/")!
    }
    
    var header: [String: String]? {
        return nil
    }
    
    func toURLRequest() -> URLRequest {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        switch parameters {
        case .none:
            break
        case .query(let parameter):
            let dict = parameter.asDictionary()
            var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
            var queryItems: [URLQueryItem] = []
            for key in dict.keys {
                var queryItem = URLQueryItem(name: key, value: "\(dict[key]!)")
                queryItems.append(queryItem)
            }
            urlComponents?.queryItems = queryItems
            request.url = urlComponents?.url
        case .body(let parameter):
            request.httpBody = try? JSONEncoder().encode(parameter)
        }
        
        return request
    }
    
}

extension Encodable {
  func asDictionary() -> [String: Any] {
    guard let data = try? JSONEncoder().encode(self) else { return [:] }
    guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        return [:]
    }
    return dictionary
  }
}
