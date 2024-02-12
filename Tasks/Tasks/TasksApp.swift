// Importa el framework SwiftUI, necesario para construir la interfaz de usuario.
import SwiftUI

// La anotación '@main' identifica la estructura siguiente como el punto de entrada de la aplicación.
@main
// Define la estructura 'TasksApp', que conforma el protocolo 'App' de SwiftUI.
struct TasksApp: App {
    // Declara 'taskStore' como una propiedad de estado observable que se mantendrá viva durante toda la vida de la aplicación.
    // Al usar '@StateObject', SwiftUI se encargará de crear y mantener la instancia de 'TaskStore' a través de reconstrucciones de la vista.
    @StateObject var taskStore = TaskStore()

    // Define el cuerpo de la aplicación, que es donde configuras las vistas iniciales y el comportamiento de la aplicación.
    var body: some Scene {
        // Crea un grupo de ventanas para la interfaz de usuario principal de la aplicación.
        WindowGroup {
            // Establece 'ContentView' como la vista raíz y proporciona 'taskStore' a la jerarquía de vistas.
            // Al utilizar '.environmentObject', cualquier vista descendiente podrá acceder a 'taskStore' si lo necesita.
            ContentView().environmentObject(taskStore)
        }
    }
}
