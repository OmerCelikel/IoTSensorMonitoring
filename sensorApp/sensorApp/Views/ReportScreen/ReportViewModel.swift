//
//  ReportViewModel.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 28.04.2023.
//

import Foundation

class ReportViewModel {
    private let service = AFGasService()
    
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
