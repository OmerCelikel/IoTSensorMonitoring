//
//  AFService.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

import Alamofire

struct Gas: Codable {
    let name: String
    let time: Date
    let value: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case time = "Time"
        case value = "Value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        let timeString = try container.decode(String.self, forKey: .time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let time = dateFormatter.date(from: timeString) else {
            throw DecodingError.dataCorruptedError(forKey: .time, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        self.time = time
        
        value = try container.decode(Double.self, forKey: .value)
    }
}

class AFGasService {
    //phone
//    private let baseURL = "http://192.168.43.56:5000"
    private let baseURL = "http://192.168.1.42:5000"
    //base
//    private let baseURL = "http://127.0.0.1:5000"
    
    //wifi
//    private let baseURL = "http://10.76.149.209:5000"
    
    
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
    
    func postReport(date: String, field: String, completion: @escaping (Result<[Gas], AFError>) -> Void) {
        let url = "\(baseURL)/reports"
        let parameters: [String: Any] = ["Date": date, "Field": field]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: [Gas].self) { response in
            switch response.result {
            case .success(let reports):
                completion(.success(reports))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
