//
//  FlickrPhotosSearchResponse.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework Foundation, que proporciona las herramientas necesarias para trabajar con URL y datos decodificables, entre otras cosas.
import Foundation

// Define una estructura llamada `FlickrPhotosSearchResponse` que conforma al protocolo `Decodable`, permitiéndola decodificar datos desde formatos externos como JSON.
struct FlickrPhotosSearchResponse: Decodable {
    // Contiene los detalles de las fotos y la paginación.
    let photos: FlickrPhotos
    // Indica el estado de la respuesta, como "ok" para respuestas exitosas.
    let stat: String
}

// Define una estructura para representar los detalles y la lista de fotos obtenidas en la búsqueda.
struct FlickrPhotos: Decodable {
    // Número de la página actual de resultados.
    let page: Int
    // Número total de páginas de resultados.
    let pages: Int
    // Número de fotos por página.
    let perpage: Int
    // Número total de fotos disponibles.
    let total: Int
    // Arreglo de fotos, donde cada foto se representa con la estructura `FlickrPhoto`.
    let photo: [FlickrPhoto]
}

// Define una estructura para representar una foto individual de Flickr.
struct FlickrPhoto: Decodable {
    // Identificador único de la foto.
    let id: String
    // Identificador del propietario de la foto.
    let owner: String
    // Clave secreta de la foto, usada en la construcción de URLs.
    let secret: String
    // Identificador del servidor donde se aloja la foto.
    let server: String
    // Número de granja de servidores de Flickr donde se aloja la foto.
    let farm: Int
    // Título de la foto.
    let title: String
    // Indica si la foto es pública (1) o no (0).
    let ispublic: Int
    // Indica si la foto pertenece a un amigo (1) o no (0).
    let isfriend: Int
    // Indica si la foto es de familia (1) o no (0).
    let isfamily: Int

    // Propiedad computada que construye la URL de la imagen a partir de sus componentes.
    var imageURL: URL? {
        // Formato base para las URLs de las imágenes de Flickr.
        let baseURL = "https://live.staticflickr.com/%@/%@_%@_w.jpg"
        // Construye la URL sustituyendo los placeholders por los valores de `server`, `id` y `secret`.
        let urlString = String(format: baseURL, server, id, secret)
        // Devuelve un objeto URL si la cadena formada es una URL válida, o nil en caso contrario.
        return URL(string: urlString)
    }
}
