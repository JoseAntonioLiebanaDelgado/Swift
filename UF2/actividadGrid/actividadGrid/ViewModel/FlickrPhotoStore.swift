//
//  FlickrPhotoStore.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importación del framework Foundation, necesario para interactuar con el sistema y realizar operaciones de red, entre otras cosas.
import Foundation

// Definición de la clase `FlickrPhotoStore` que se adhiere al protocolo `ObservableObject`. Esto permite que las instancias de esta clase puedan ser observadas por SwiftUI para cambios en sus propiedades `@Published`.
class FlickrPhotoStore: ObservableObject{

    // Define una constante estática para la clave API necesaria para hacer solicitudes a la API de Flickr.
    static let api_key = "a4f28588b57387edc18282228da39744"

    // Define una variable estática para la URL de búsqueda de la API de Flickr. Incluye la clave API y los parámetros predeterminados para la búsqueda.
    static var searchURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key)&format=json&nojsoncallback=1&text=nature"
    
    
    // Una propiedad `@Published` que almacena un array de `FlickrPhoto`. Esto permite a la interfaz de usuario observar y reaccionar a los cambios en esta propiedad.
    @Published private(set) var fotosFlickr = [FlickrPhoto]()
    
    // Una propiedad `@Published` para almacenar errores que puedan ocurrir durante la búsqueda de fotos. Esto permite mostrar mensajes de error en la interfaz de usuario.
    @Published private(set) var error:FetchError?
    
    // Función `loadData` que acepta un `searchInputUser` como parámetro, el cual es el término de búsqueda proporcionado por el usuario. Esta función actualiza la URL de búsqueda con el término de búsqueda del usuario y luego llama a `fetchData` para realizar la solicitud a la API.
    func loadData(searchInputUser: String) {
        FlickrPhotoStore.searchURL = "\(FlickrPhotoStore.searchURL)&text=\(searchInputUser)"
        fetchData{result in
            switch(result){
                // En caso de éxito, actualiza la propiedad `fotosFlickr` con el array de fotos obtenidas y las imprime en la consola.
                case .success(let arrayFotos):
                    DispatchQueue.main.async {
                        self.fotosFlickr = arrayFotos
                        print(self.fotosFlickr)
                    }

                // En caso de error, imprime el error en la consola y actualiza la propiedad `error` con el error ocurrido.
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.error = error
                    }
            }
        }
    }

    // Función privada `fetchData` que realiza la solicitud a la API y maneja la respuesta. Utiliza un `completion` handler para devolver el resultado de la solicitud, que puede ser un array de `FlickrPhoto` o un error.
    private func fetchData(completion: @escaping(Result<[FlickrPhoto],FetchError>)->Void) {
        // Verifica que la URL de búsqueda sea válida.
        guard let postURL = URL(string: FlickrPhotoStore.searchURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Realiza una tarea de red asincrónica para obtener los datos de la URL especificada.
        URLSession.shared.dataTask(with: postURL) { data, response, error in
            // Maneja un posible error en la sesión de URL.
            if let urlSessionError = error {
                completion(.failure(.urlSessionError(urlSessionError)))
                return
            }

            // Verifica que los datos recibidos sean válidos.
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            // Intenta decodificar la respuesta JSON en un objeto `FlickrPhotosSearchResponse`.
            do{
                let datos = try JSONDecoder().decode(FlickrPhotosSearchResponse.self, from: data)
                // Si la decodificación es exitosa, pasa el array de fotos al `completion` handler.
                completion(.success(datos.photos.photo))
            }catch{
                // Maneja un posible error en la decodificación.
                print(error)
                completion(.failure(.decodingFailed))
            }
        }.resume() // Reanuda la tarea suspendida para que se ejecute.
    }
}
