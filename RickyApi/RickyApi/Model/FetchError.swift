//
//  FetchError.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import Foundation

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
