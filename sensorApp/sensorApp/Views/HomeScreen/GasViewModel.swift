//
//  GasViewModel.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 20.04.2023.
//

class GasViewModel {
    private let service = AFGasService()
    var gases: [Gas] = []
    
    func getAllGases(completion: @escaping (Result<[Gas], Error>) -> Void) {
        service.getAllGases { result in
            switch result {
            case .success(let gases):
                self.gases = gases
                completion(.success(gases))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postGasReport(date: String, field: String, completion: @escaping (Result<[Gas], Error>) -> Void) {
        service.postReport(date: date, field: field) { result in
            switch result {
            case .success(let reports):
                completion(.success(reports))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
