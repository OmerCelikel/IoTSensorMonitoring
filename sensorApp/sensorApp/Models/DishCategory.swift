//
//  DishCategory.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 28.03.2023.
//

import Foundation
struct DishCategory: Decodable {
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
