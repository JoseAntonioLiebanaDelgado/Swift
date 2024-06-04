import SwiftUI

@main
struct RecipesApp: App {
    // Singleton de PersistenceController para manejar el almacenamiento de datos.
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // Obtiene el contexto de Core Data del contenedor de PersistenceController.
            let context = persistenceController.container.viewContext
            // Crea una instancia de RecipeStore con el contexto de Core Data.
            let recipeStore = RecipeStore(context: context)
            // Establece ContentView como la vista principal y proporciona el contexto y RecipeStore al entorno.
            ContentView()
                .environment(\.managedObjectContext, context)
                .environmentObject(recipeStore)
        }
    }
}

