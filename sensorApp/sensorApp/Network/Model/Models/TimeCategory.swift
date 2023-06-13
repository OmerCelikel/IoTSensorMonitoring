//
//  TimeCategory.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 28.03.2023.
//

import Foundation
struct TimeCategory: Equatable {
    let id, name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
    }
}
