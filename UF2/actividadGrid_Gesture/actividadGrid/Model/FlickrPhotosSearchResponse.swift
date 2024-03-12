//
//  FlickrPhotosSearchResponse.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework Foundation, necesario para trabajar con tipos de datos no específicos de la interfaz de usuario, como strings y URLs.
import Foundation

// Define una estructura llamada FlickrPhotosSearchResponse que conforma al protocolo Decodable, lo que permite decodificarla desde datos JSON.
struct FlickrPhotosSearchResponse: Decodable {
    // Almacena información sobre las fotos, encapsulada en una instancia de FlickrPhotos.
    let photos: FlickrPhotos
    // Almacena el estado de la respuesta, que puede ser usado para verificar si la solicitud fue exitosa.
    let stat: String
}

// Define una estructura llamada FlickrPhotos que también conforma al protocolo Decodable.
struct FlickrPhotos: Decodable {
    // Almacena el número de página actual de la respuesta.
    let page: Int
    // Almacena el número total de páginas disponibles.
    let pages: Int
    // Almacena el número de fotos por página.
    let perpage: Int
    // Almacena el total de fotos disponibles que coinciden con el criterio de búsqueda.
    let total: Int
    // Almacena un arreglo de instancias de FlickrPhoto, que representan las fotos individuales.
    let photo: [FlickrPhoto]
}

// Define una estructura para las fotos individuales, también conformando a Decodable.
struct FlickrPhoto: Decodable {
    // Propiedades que almacenan varios identificadores y metadatos de cada foto.
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    
    // Una propiedad computada que genera la URL de la imagen de la foto basada en sus propiedades.
    var imageURL: URL? {
        let baseURL = "https://live.staticflickr.com/%@/%@_%@_w.jpg"
        let urlString = String(format: baseURL, server, id, secret)
        return URL(string: urlString)
    }
}

