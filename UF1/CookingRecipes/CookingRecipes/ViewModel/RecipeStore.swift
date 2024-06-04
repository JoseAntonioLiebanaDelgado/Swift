import SwiftUI
import CoreData

class RecipeStore: ObservableObject {
    @Published var recipes: [Recetas] = []
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchRecipes()
    }
    
    func fetchRecipes() {
        let request: NSFetchRequest<Recetas> = Recetas.fetchRequest()
        
        do {
            recipes = try viewContext.fetch(request)
        } catch {
            print("Error fetching recipes: \(error)")
        }
    }
    
    func addRecipe(title: String, ingredients: String, isFavorite: Bool) {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.title = title
        newRecipe.ingredients = ingredients
        newRecipe.isFavorite = isFavorite
        
        saveContext()
    }
    
    func deleteRecipe(at offsets: IndexSet) {
        offsets.forEach { index in
            let recipe = recipes[index]
            viewContext.delete(recipe)
        }
        
        saveContext()
    }
    
    func updateRecipe(recipe: Recipe, title: String, ingredients: String, isFavorite: Bool) {
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.isFavorite = isFavorite
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchRecipes()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
