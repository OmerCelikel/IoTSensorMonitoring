//
//  GasService.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

protocol GasServiceProtocol {
    func getAllGasses(completion: @escaping (Result<RealTimeAllGasses, NetworkError>) -> Void)
    func gasReport(name: String, time: String, completion: @escaping (Result<SensorData, NetworkError>) -> Void)
}

struct GasService: GasServiceProtocol {
    
    let network = Network()
    
    func getAllGasses(completion: @escaping (Result<RealTimeAllGasses, NetworkError>) -> Void) {
        network.performRequest(request: GasRequest.allGasses, completion: completion)
    }
    
    func gasReport(name: String, time: String, completion: @escaping (Result<SensorData, NetworkError>) -> Void) {
        network.performRequest(request: GasRequest.reports(name: name, time: time) ,completion: completion)
    }
    
}
