// Importa el framework SwiftUI para construir la interfaz de usuario.
import SwiftUI

// Indica el punto de entrada principal de la aplicación.
@main
struct FrameByFrameMVVMApp: App {
    // Crea un objeto de tipo `ViewModel` que será compartido en todo el entorno.
    @StateObject var viewModel = ViewModel()

    // Define el cuerpo de la aplicación, que contiene una o más escenas.
    var body: some Scene {
        // Crea un grupo de ventanas para la interfaz principal de la aplicación.
        WindowGroup {
            // Establece `ContentView` como la vista principal y comparte el objeto `viewModel`
            // en el entorno de vistas a través de `@EnvironmentObject`.
            ContentView().environmentObject(viewModel)
        }
    }
}
