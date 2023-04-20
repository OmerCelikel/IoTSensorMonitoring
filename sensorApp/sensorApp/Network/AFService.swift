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
    let Time: Date
    let Value: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Name = try container.decode(String.self, forKey: .Name)
        
        let timeString = try container.decode(String.self, forKey: .Time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let time = dateFormatter.date(from: timeString) else {
            throw DecodingError.dataCorruptedError(forKey: .Time, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        Time = time
        
        Value = try container.decode(Double.self, forKey: .Value)
    }
}

struct ReportModel: Codable {
    let Name: String
    let Time: Date
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
