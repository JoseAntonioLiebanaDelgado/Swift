//
//  FetchError.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
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
