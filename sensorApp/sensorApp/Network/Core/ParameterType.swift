//
//  ParameterType.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 16.04.2023.
//

import Foundation

enum ParameterType {
    
    case none
    case query(parameter: Encodable)
    case body(parameter: Encodable)
    
}
