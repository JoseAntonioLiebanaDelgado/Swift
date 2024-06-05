import SwiftUI

@main
struct RecipesApp: App {
    let persistenceController = PersistenceController.shared  // Instancia compartida del controlador de persistencia

    var body: some Scene {
        WindowGroup {
            let context = persistenceController.container.viewContext  // Obtener el contexto de Core Data
            let recipeStore = RecipeStore(context: context)  // Crear una instancia de RecipeStore con el contexto
            ContentView()
                .environment(\.managedObjectContext, context)  // Proveer el contexto al entorno de SwiftUI
                .environmentObject(recipeStore)  // Proveer la instancia de RecipeStore al entorno de SwiftUI
        }
    }
}
