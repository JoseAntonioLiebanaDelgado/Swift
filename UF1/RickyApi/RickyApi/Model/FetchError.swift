//
//  FetchError.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import Foundation

// case invalidURL: Representa un error que se produce cuando la URL utilizada para la solicitud de red no es válida.
// case invalidData: Indica que los datos recibidos de la solicitud de red no son válidos o no están en el formato esperado.
// case decodingFailed: Significa que el proceso de decodificación de los datos (por ejemplo, de JSON a una estructura Codable) ha fallado.
// case urlSessionError(Error): Este caso es un poco diferente, ya que puede capturar y almacenar un error asociado con una sesión de URL (URLSession).
// Permite que cualquier error generado durante una sesión de red se encapsule y pase a través de esta enumeración.

enum FetchError:Error{
    case invalidURL
    case invalidData
    case decodingFailed
    case urlSessionError(Error)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "☹️ Error invalid URL."
        case .invalidData:
            return "☹️ Error invalid data."
        case .decodingFailed:
            return "☹️ Error al descodificar los datos."
        case .urlSessionError:
            return "☹️ Error con las session introducida."
        }
    }
}
