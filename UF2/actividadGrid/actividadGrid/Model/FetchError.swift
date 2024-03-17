//
//  FetchError.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework Foundation, necesario para usar el protocolo Error entre otras funcionalidades.
import Foundation

// Define un enum llamado FetchError que adopta el protocolo Error, permitiendo su uso para representar errores en Swift.
enum FetchError: Error {
    // Define posibles casos de error que se pueden encontrar al realizar solicitudes de red o al procesar las respuestas.
    
    case invalidURL // Representa un error que ocurre cuando la URL utilizada para la solicitud de red es inválida.
    case invalidData // Representa un error que ocurre cuando los datos recibidos de la respuesta de red son inválidos o no se pueden usar.
    case decodingFailed // Representa un error que ocurre durante el proceso de decodificación de los datos recibidos, típicamente al convertirlos de JSON a un tipo de datos de Swift.
    case urlSessionError(Error) // Representa un error que se produce dentro de una sesión URL, incluyendo errores de red y otros errores de URLSession. Este caso lleva asociado el error específico de URLSession para más detalles.
    
    // Propiedad computada `description` que proporciona un mensaje legible para cada caso de error.
    var description: String {
        switch self {
        case .invalidURL: // Caso para un URL inválido.
            return "☹️ Error invalid URL." // Retorna un mensaje indicando que el URL es inválido.
        case .invalidData: // Caso para datos inválidos.
            return "☹️ Error invalid data." // Retorna un mensaje indicando que los datos son inválidos.
        case .decodingFailed: // Caso para fallos en la decodificación.
            return "☹️ Error al descodificar los datos." // Retorna un mensaje indicando que hubo un error al decodificar los datos.
        case .urlSessionError: // Caso para errores generales de URLSession.
            return "☹️ Error con las session introducida." // Retorna un mensaje indicando que hubo un error con la sesión de URLSession.
        }
    }
}

