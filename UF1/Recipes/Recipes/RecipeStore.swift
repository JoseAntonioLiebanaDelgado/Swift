import SwiftUI
import CoreData

class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe] = []
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchRecipes()
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: .NSManagedObjectContextObjectsDidChange, object: context)
    }

    @objc private func contextObjectsDidChange(_ notification: Notification) {
        fetchRecipes()
    }

    func fetchRecipes() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            recipes = try context.fetch(request)
        } catch {
            print("Error fetching recipes: \(error)")
        }
    }

    func addRecipe(_ recipe: Recipe) {
        //TODO: Buscar recetas con el mismo nombre para ver si existe alguna.
        // Si existe o no una dar valor true o false a variable repe
        let repe = false
        if (!repe) {
            recipes.append(recipe)
            saveContext()
        }
    }

    func deleteRecipe(at offsets: IndexSet) {
        for index in offsets {
            let recipe = recipes[index]
            recipes.remove(at: index)
            context.delete(recipe)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
