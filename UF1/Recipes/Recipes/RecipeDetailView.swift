import SwiftUI

struct RecipeDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var recipe: Recipe

    @State private var newIngredientName = ""
    @State private var newIngredientQuantity = ""
    
    var body: some View {
        VStack {
            TextField("Title", text: Binding($recipe.title, ""))
                .font(.largeTitle)
                .padding()

            Toggle(isOn: Binding(
                get: { recipe.isFavorite },
                set: { recipe.isFavorite = $0 }
            )) {
                Text("Favorite")
            }
            .padding()

            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredientsArray, id: \.self) { ingredient in
                        HStack {
                            TextField("Name", text: Binding(
                                get: { ingredient.name ?? "Unnamed Ingredient" },
                                set: { ingredient.name = $0 }
                            ))
                            Spacer()
                            TextField("Quantity", text: Binding(
                                get: { ingredient.quantity ?? "" },
                                set: { ingredient.quantity = $0 }
                            ))
                        }
                    }
                    .onDelete(perform: deleteIngredient)
                    
                    HStack {
                        TextField("New Ingredient Name", text: $newIngredientName)
                        TextField("Quantity", text: $newIngredientQuantity)
                        Button(action: addIngredient) {
                            Text("Add")
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(recipe.title ?? "Recipe Details"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: saveChanges) {
            Text("Save")
        })
    }
    
    private func addIngredient() {
        guard !newIngredientName.isEmpty else { return }
        
        if recipe.ingredientsArray.contains(where: { $0.name?.lowercased() == newIngredientName.lowercased() }) {
            // Ingredient with this name already exists, handle accordingly (e.g., show a message)
            print("Ingredient with this name already exists.")
            return
        }

        let newIngredient = Ingridient(context: viewContext)
        newIngredient.name = newIngredientName
        newIngredient.quantity = newIngredientQuantity
        newIngredient.recipe = recipe
        recipe.addToIngredients(newIngredient)
        
        newIngredientName = ""
        newIngredientQuantity = ""
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        for index in offsets {
            let ingredient = recipe.ingredientsArray[index]
            viewContext.delete(ingredient)
        }
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}

extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) where Value: Equatable {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}
