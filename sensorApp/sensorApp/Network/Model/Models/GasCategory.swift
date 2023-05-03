//
//  GasCategory.swift
//  sensorApp
//
//  Created by Ömer Oğuz Çelikel on 8.04.2023.
//

import Foundation
struct GasCategory: Decodable {
    let id: String?
    let name: String?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
    }
    
    init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
