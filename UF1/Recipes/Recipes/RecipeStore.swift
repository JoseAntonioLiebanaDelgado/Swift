import SwiftUI
import CoreData

// Clase que maneja la lógica de negocio para las recetas
class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe] = []  // Array publicado de recetas
    private var context: NSManagedObjectContext  // Contexto de Core Data

    // Inicializador que toma el contexto de Core Data
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchRecipes()  // Cargar recetas desde la base de datos
        // Observador para cambios en el contexto de Core Data
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: .NSManagedObjectContextObjectsDidChange, object: context)
    }

    // Método llamado cuando el contexto cambia
    @objc private func contextObjectsDidChange(_ notification: Notification) {
        fetchRecipes()  // Volver a cargar recetas desde la base de datos
    }

    // Método para obtener recetas desde Core Data
    func fetchRecipes() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()  // Solicitud de recetas
        do {
            recipes = try context.fetch(request)  // Ejecutar la solicitud y asignar el resultado
        } catch {
            print("Error fetching recipes: \(error)")  // Manejar errores de solicitud
        }
    }

    // Método para agregar una receta a la base de datos
    func addRecipe(_ recipe: Recipe) {
        let repe = false
        if (!repe) {  // Verificar si la receta no está duplicada (lógica pendiente)
            recipes.append(recipe)  // Agregar receta al array
            saveContext()  // Guardar cambios en el contexto
        }
    }

    // Método para eliminar una receta
    func deleteRecipe(at offsets: IndexSet) {
        for index in offsets {
            let recipe = recipes[index]  // Obtener receta por índice
            recipes.remove(at: index)  // Remover receta del array
            context.delete(recipe)  // Eliminar receta del contexto
        }
        saveContext()  // Guardar cambios en el contexto
    }

    // Método privado para guardar cambios en Core Data
    private func saveContext() {
        do {
            try context.save()  // Intentar guardar el contexto
        } catch {
            print("Error saving context: \(error)")  // Manejar errores de guardado
        }
    }
}
