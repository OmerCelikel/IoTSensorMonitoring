//
//  GasRequest.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

enum GasRequest: Requestable {
   
    case allGasses
    case reports(name: String, time: String)
    
    var path: String {
        switch self {
        case.allGasses:
            return "values"
        case .reports:
            return "reports"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allGasses:
            return .get
        case .reports:
            return .post
        }
    }
    
    var parameters: ParameterType {
        switch self {
        case .allGasses:
            return .none
        case .reports(let name, let time):
            return .body(parameter: RealTimeGasRequest(Name: name, Time: time))
        }
    }
    
}
