//
//  Network.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

struct Network {
        
    func performRequest<T: Codable>(request: Requestable, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.toURLRequest()) { data, response, error in
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else if let error = error {
                completion(.failure(.networkError(descripton: error.localizedDescription)))
            } else {
                completion(.failure(.unknownError))
            }
        }
        task.resume()
    }
    
}

enum NetworkError: Error {
    
    case decodingError
    case networkError(descripton: String)
    case unknownError
    
}
