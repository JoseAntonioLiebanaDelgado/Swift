//
//  RickyMortin.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import Foundation

struct RickyMortin: Codable, Identifiable {
    let id: Int
    let name, species: String
    let image: String
    
    var imageUrl: URL? {
        return URL(string: image)
    }
    
    static var defaultValue = RickyMortin(
        id: 1,
        name: "Mortin",
        species: "Human",
        image: ""
    )
}
