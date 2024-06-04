import SwiftUI

struct RecipeCreateView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var ingredients = ""
    @State private var isFavorite = false
    @EnvironmentObject var recipeStore: RecipeStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Title", text: $title)
                    TextField("Ingredients", text: $ingredients)
                    Toggle(isOn: $isFavorite) {
                        Text("Favorite")
                    }
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
    
    private func saveRecipe() {
        recipeStore.addRecipe(title: title, ingredients: ingredients, isFavorite: isFavorite)
    }
}
