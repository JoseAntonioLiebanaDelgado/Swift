// Importa el framework SwiftUI para poder usar sus funcionalidades.
import SwiftUI

// Marca la estructura siguiente como el punto de entrada de la aplicación.
@main
// Define la estructura 'FruitsDemoApp' que conforma el protocolo 'App'.
struct FruitsDemoApp: App {
    // Define la propiedad computada 'body' que devuelve una escena para la interfaz de usuario.
    var body: some Scene {
        // Un contenedor para una o más ventanas de interfaz de usuario en la app.
        WindowGroup {
            // Crea una instancia de ContentView, que será la primera vista en mostrarse.
            ContentView()
                // Añade un objeto de entorno 'FruitStore' a los objetos disponibles en toda la jerarquía de vistas.
                .environmentObject(FruitStore())
        }
    }
}
