//
//  RickyMortin.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import Foundation

// Codable: Al conformar al protocolo Codable, se indica que la estructura RickyMortin puede codificarse y decodificarse a y desde un formato externo, como JSON. Esto es útil para la serialización de datos para su almacenamiento o transmisión a través de una API.

// Identifiable: Este protocolo se utiliza para que la estructura pueda ser utilizada con facilidad en listas o colecciones que necesitan identificar de manera única cada instancia, como por ejemplo en las vistas de listas de SwiftUI. Requiere que exista una propiedad llamada id que sea única para cada instancia.

struct RickyMortin: Codable, Identifiable {
    let id: Int
    let name, species: String
    let image: String
    
    var imageUrl: URL? {
        return URL(string: image)
    }
    
    
    // static var defaultValue: Define una propiedad estática llamada defaultValue. Las propiedades estáticas son valores que pertenecen a la estructura misma, en lugar de a una instancia de la estructura. Aquí se proporciona un valor predeterminado para RickyMortin, lo que puede ser útil como valor de placeholder o durante el desarrollo y pruebas.ç
    
    static var defaultValue = RickyMortin(
        id: 1,
        name: "Mortin",
        species: "Human",
        image: ""
    )
}
