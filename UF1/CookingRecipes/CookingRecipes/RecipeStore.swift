import SwiftUI
import CoreData

class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe] = []
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchRecipes()
    }
    
    func fetchRecipes() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        
        do {
            recipes = try viewContext.fetch(request)
        } catch {
            print("Error fetching recipes: \(error)")
        }
    }
    
    func addRecipe(title: String, isFavorite: Bool, ingredients: [String: String]) {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.title = title
        newRecipe.isFavorite = isFavorite
        
        for (name, quantity) in ingredients {
            let newIngredient = Ingredient(context: viewContext)
            newIngredient.name = name
            newIngredient.quantity = quantity
            newIngredient.recipe = newRecipe
            newRecipe.ingredients?.insert(newIngredient)
        }
        
        saveContext()
    }
    
    func deleteRecipe(at offsets: IndexSet) {
        offsets.forEach { index in
            let recipe = recipes[index]
            viewContext.delete(recipe)
        }
        
        saveContext()
    }
    
    func updateRecipe(recipe: Recipe, title: String, isFavorite: Bool, ingredients: [String: String]) {
        recipe.title = title
        recipe.isFavorite = isFavorite
        
        // Delete existing ingredients
        if let existingIngredients = recipe.ingredients {
            for ingredient in existingIngredients {
                viewContext.delete(ingredient)
            }
        }
        
        // Add new ingredients
        for (name, quantity) in ingredients {
            let newIngredient = Ingredient(context: viewContext)
            newIngredient.name = name
            newIngredient.quantity = quantity
            newIngredient.recipe = recipe
            recipe.ingredients?.insert(newIngredient)
        }
        
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
