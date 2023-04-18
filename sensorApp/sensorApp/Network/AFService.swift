//
//  AFService.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

import Alamofire

struct Gas: Codable {
    let Name: String
//    let Time: Date
    let Value: Double
}

struct ReportModel: Codable {
    let Name: String
//    let time: String
    let Value: Double
}


class AFGasService {
    
    private let baseURL = "http://127.0.0.1:5000"
    
    func getAllGases(completion: @escaping (Result<[Gas], Error>) -> Void) {
        AF.request("\(baseURL)/values").validate().responseDecodable(of: [Gas].self) { response in
            switch response.result {
            case .success(let gases):
                completion(.success(gases))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postReport(date: String, field: String, completion: @escaping (Result<[ReportModel], AFError>) -> Void) {
        let url = "\(baseURL)/reports"
        let parameters: [String: Any] = ["Date": date, "Field": field]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: [ReportModel].self) { response in
            switch response.result {
            case .success(let reports):
                completion(.success(reports))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
