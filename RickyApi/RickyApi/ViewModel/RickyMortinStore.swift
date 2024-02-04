//
//  RickyMortinStore.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import Foundation

//La clase RickyMortinStore adopta el protocolo ObservableObject. Esto significa que cualquier objeto de esta clase puede ser observado por la interfaz de usuario para cambios en sus datos, lo cual es un patrón común en SwiftUI para la reactividad.

class RickyMortinStore: ObservableObject{
    
    private let baseStringURL = "https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10"
    
    // @Published private(set) var rickyMortinsData = [RickyMortin](): Aquí se declara una propiedad que almacena un array de RickyMortin. El modificador @Published hace que cualquier cambio en este array notifique a los observadores (por ejemplo, la interfaz de usuario en SwiftUI). private(set) significa que solo se puede modificar dentro de la clase RickyMortinStore.
    
    @Published private(set) var rickyMortinsData = [RickyMortin]()
    
    // @Published private(set) var error: FetchError?: Esta es otra propiedad @Published que almacena un error de tipo FetchError. Se usa para capturar y comunicar errores que puedan ocurrir durante la carga de datos.
    
    @Published private(set) var error:FetchError?
    
    // init(): Es el inicializador de la clase. Llama a loadData() para cargar los datos cuando se crea una instancia de RickyMortinStore.
    
    init(){
        loadData()
    }
    
    // func loadData(): Es una función pública que inicia el proceso de carga de datos llamando a fetchData, y maneja el resultado con una closure que procesa el éxito o el fallo de la solicitud.
    
    // Define la función loadData que se encarga de cargar los datos
    func loadData() {
        // Llama a la función fetchData y maneja su resultado asincrónico
        fetchData { result in
            // Utiliza switch para manejar los casos de éxito o fallo
            switch(result) {
            // En caso de éxito...
            case .success(let arrayRickyMortin):
                // Ejecuta la actualización de la interfaz de usuario en el hilo principal
                DispatchQueue.main.async {
                    // Asigna el resultado exitoso a la propiedad rickyMortinsData
                    self.rickyMortinsData = arrayRickyMortin
                }
                // Imprime el array de RickyMortin para depuración
                print(self.rickyMortinsData)

            // En caso de fallo...
            case .failure(let error):
                // Imprime el error para depuración
                print(error)
                // Ejecuta la actualización de la interfaz de usuario en el hilo principal
                DispatchQueue.main.async {
                    // Asigna el error a la propiedad error
                    self.error = error
                }
            }
        }
    }

    
    
    // Define una función privada fetchData que realiza una llamada a la red y devuelve el resultado a través de una closure de finalización.
    private func fetchData(completion: @escaping(Result<[RickyMortin],FetchError>)->Void) {
        // Intenta convertir la cadena baseStringURL en un objeto URL y maneja el caso de fallo.
        guard let postURL = URL(string: baseStringURL) else {
            // Llama a la closure de finalización con un resultado de fallo si la URL es inválida.
            completion(.failure(.invalidURL))
            return
        }
        
        // Inicia una tarea de red con la URL formada.
        URLSession.shared.dataTask(with: postURL) { data, response, error in
            // Comprueba si hubo un error en la sesión de URL y, de ser así, completa con ese error.
            if let urlSessionError = error {
                completion(.failure(.urlSessionError(urlSessionError)))
                return
            }

            // Comprueba si los datos recibidos son nulos y, de ser así, completa con un error de datos inválidos.
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                // Intenta decodificar los datos recibidos en un array de RickyMortin.
                let datos = try JSONDecoder().decode([RickyMortin].self, from: data)
                // Llama a la closure de finalización con un resultado exitoso si la decodificación fue correcta.
                completion(.success(datos))
            } catch {
                // Imprime el error de decodificación para depuración.
                print(error)
                // Llama a la closure de finalización con un resultado de fallo si la decodificación falla.
                completion(.failure(.decodingFailed))
            }
        // Reactiva la tarea de red suspendida.
        }.resume()
    }

}
