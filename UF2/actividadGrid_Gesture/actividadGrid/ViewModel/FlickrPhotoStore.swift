//
//  FlickrPhotoStore.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework Foundation, necesario para trabajar con tipos de datos fundamentales y colecciones, realizar operaciones de red, entre otras cosas.
import Foundation

// Define una clase llamada FlickrPhotoStore que conforma al protocolo ObservableObject, permitiendo que sus propiedades publicadas disparen actualizaciones de la vista.
class FlickrPhotoStore: ObservableObject{
    
    // Una propiedad que almacena la URL de búsqueda, inicialmente vacía, pero accesible fuera de la clase.
    private(set) var url: String = ""

    // Define una clave API estática y privada para el uso de la API de Flickr.
    static let api_key = "a4f28588b57387edc18282228da39744"

    // Construye la URL base para la búsqueda en la API de Flickr, usando la clave API.
    static var searchURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key)&format=json&nojsoncallback=1"
    
    // @Published marca la propiedad fotosFlickr para que, cuando cambie, SwiftUI actualice cualquier vista que dependa de esta propiedad.
    @Published private(set) var fotosFlickr = [FlickrPhoto]()
    
    // @Published marca la propiedad error para manejar y mostrar errores de manera reactiva en la UI.
    @Published private(set) var error:FetchError?
    
    // La función loadData inicia la carga de datos de fotos desde Flickr, basándose en la entrada de búsqueda del usuario.
    func loadData(searchInputUser: String) {
        // Reemplaza espacios en la entrada del usuario con "+" para construir una URL válida de búsqueda.
        let searchInputUserFilterd = searchInputUser.replacingOccurrences(of: " ", with: "+")
        // Construye la URL final de búsqueda añadiendo la entrada del usuario a la URL base.
        url = "\(FlickrPhotoStore.searchURL)&text=\(searchInputUserFilterd)"
        // Imprime la URL para depuración.
        print(url)
        // Inicia la petición de red y maneja el resultado con un closure.
        fetchData{result in
            switch(result){
                // En caso de éxito, actualiza la lista de fotos en el hilo principal.
                case .success(let arrayFotos):
                    DispatchQueue.main.async {
                        self.fotosFlickr = arrayFotos
                    }

                // En caso de falla, actualiza la propiedad error en el hilo principal.
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.error = error
                    }
            }
        }
    }
    // Define la función fetchData que realiza la petición de red y decodifica la respuesta.
    private func fetchData(completion: @escaping(Result<[FlickrPhoto],FetchError>)->Void) {
        // Crea un objeto URL a partir de la cadena de la URL almacenada.
        guard let postURL = URL(string: self.url) else {
            // Si la URL no es válida, completa con un error y retorna.
            completion(.failure(.invalidURL))
            return
        }
        
        // Inicia una tarea de red con la URL.
        URLSession.shared.dataTask(with: postURL) { data, response, error in
            // Maneja el caso de error en la sesión de URL.
            if let urlSessionError = error {
                completion(.failure(.urlSessionError(urlSessionError)))
                return
            }

            // Asegura que los datos recibidos no son nulos.
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            // Intenta decodificar la respuesta JSON en un objeto FlickrPhotosSearchResponse.
            do{
                let datos = try JSONDecoder().decode(FlickrPhotosSearchResponse.self, from: data)
                // En caso de éxito, completa con un array de fotos Flickr.
                completion(.success(datos.photos.photo))
            }catch{
                // En caso de fallo en la decodificación, completa con un error.
                print(error)
                completion(.failure(.decodingFailed))
            }
        }.resume() // Inicia la tarea de red.
    }
}

