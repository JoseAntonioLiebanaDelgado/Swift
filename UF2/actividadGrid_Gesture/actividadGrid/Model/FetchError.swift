//
//  FetchError.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework Foundation, una biblioteca base para trabajar con tipos de datos y colecciones en Swift.
import Foundation

// Define un enum llamado FetchError que conforma al protocolo Error, permitiendo su uso para manejar errores.
enum FetchError: Error {
    // Representa un error por URL inválida.
    case invalidURL
    // Representa un error por datos inválidos recibidos de la respuesta.
    case invalidData
    // Representa un error al decodificar los datos, por ejemplo, al parsear un JSON.
    case decodingFailed
    // Representa un error que ocurre durante la sesión de URL, incluyendo problemas de red o respuestas erróneas del servidor.
    case urlSessionError(Error) // Este caso también captura y almacena un error asociado.
    
    // Una propiedad computada que devuelve una descripción legible del error.
    var description: String {
        switch self {
        // Caso para una URL inválida, proporciona un mensaje de error específico.
        case .invalidURL:
            return "☹️ Error invalid URL."
        // Caso para datos inválidos, proporciona un mensaje de error específico.
        case .invalidData:
            return "☹️ Error invalid data."
        // Caso para errores al decodificar los datos, proporciona un mensaje de error específico.
        case .decodingFailed:
            return "☹️ Error al descodificar los datos."
        // Caso para errores de la sesión de URL, proporciona un mensaje de error específico.
        case .urlSessionError:
            return "☹️ Error con las session introducida."
        }
    }
}

