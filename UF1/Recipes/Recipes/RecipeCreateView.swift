import SwiftUI

struct RecipeCreateView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var isFavorite = false
    @State private var ingredients = [Ingridient]()
    @State private var ingredientName = ""
    @State private var ingredientQuantity = ""
    @EnvironmentObject var recipeStore: RecipeStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Title", text: $title)
                    Toggle(isOn: $isFavorite) {
                        Text("Favorite")
                    }
                }
                
                Section(header: Text("Ingredients")) {
                    TextField("Ingredient Name", text: $ingredientName)
                    TextField("Quantity", text: $ingredientQuantity)
                    Button(action: addIngredient) {
                        Text("Add Ingredient")
                    }
                    
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text("\(ingredient.name ?? ""): \(ingredient.quantity ?? "")")
                            Spacer()
                        }
                    }
                    .onDelete(perform: deleteIngredient)
                }
            }
            .navigationBarTitle(Text("New Recipe"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                saveRecipe()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addIngredient() {
        guard !ingredientName.isEmpty else { return }
        
        if ingredients.contains(where: { $0.name?.lowercased() == ingredientName.lowercased() }) {
            // Ingredient with this name already exists, handle accordingly (e.g., show a message)
            print("Ingredient with this name already exists.")
            return
        }

        let newIngredient = Ingridient(context: viewContext)
        newIngredient.name = ingredientName
        newIngredient.quantity = ingredientQuantity
        ingredients.append(newIngredient)
        
        ingredientName = ""
        ingredientQuantity = ""
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        for index in offsets {
            ingredients.remove(at: index)
        }
    }
    
    private func saveRecipe() {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.title = title
        newRecipe.isFavorite = isFavorite
        newRecipe.ingredients = Set(ingredients)
        
        recipeStore.addRecipe(newRecipe)
    }
}
