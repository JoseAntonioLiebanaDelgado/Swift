import SwiftUI

// Vista para crear una nueva receta
struct RecipeCreateView: View {
    @Environment(\.managedObjectContext) private var viewContext  // Contexto de Core Data desde el entorno
    @Environment(\.presentationMode) var presentationMode  // Modo de presentación para controlar el modal
    @State private var title = ""  // Estado para el título de la receta
    @State private var isFavorite = false  // Estado para indicar si la receta es favorita
    @State private var ingredients = [Ingridient]()  // Estado para almacenar los ingredientes
    @State private var ingredientName = ""  // Estado para el nombre del ingrediente actual
    @State private var ingredientQuantity = ""  // Estado para la cantidad del ingrediente actual
    @EnvironmentObject var recipeStore: RecipeStore  // Instancia de RecipeStore desde el entorno

    var body: some View {
        NavigationView {
            Form {
                // Sección para los detalles de la receta
                Section(header: Text("Recipe Details")) {
                    TextField("Title", text: $title)  // Campo para el título
                    Toggle(isOn: $isFavorite) {
                        Text("Favorite")  // Alternar para marcar como favorita
                    }
                }
                
                // Sección para los ingredientes
                Section(header: Text("Ingredients")) {
                    TextField("Ingredient Name", text: $ingredientName)  // Campo para el nombre del ingrediente
                    TextField("Quantity", text: $ingredientQuantity)  // Campo para la cantidad del ingrediente
                    Button(action: addIngredient) {
                        Text("Add Ingredient")  // Botón para agregar ingrediente
                    }
                    
                    // Lista de ingredientes añadidos
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text("\(ingredient.name ?? ""): \(ingredient.quantity ?? "")")  // Mostrar nombre y cantidad del ingrediente
                            Spacer()
                        }
                    }
                    .onDelete(perform: deleteIngredient)  // Permitir eliminación de ingredientes
                }
            }
            .navigationBarTitle(Text("New Recipe"), displayMode: .inline)  // Título de la barra de navegación
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()  // Cerrar el modal al cancelar
            }, trailing: Button("Save") {
                saveRecipe()  // Guardar la receta al hacer clic en guardar
                presentationMode.wrappedValue.dismiss()  // Cerrar el modal
            })
        }
    }
    
    // Método para agregar un ingrediente a la lista
    private func addIngredient() {
        guard !ingredientName.isEmpty else { return }  // Verificar que el nombre del ingrediente no esté vacío
        
        if ingredients.contains(where: { $0.name?.lowercased() == ingredientName.lowercased() }) {
            print("Ingredient with this name already exists.")  // Verificar si el ingrediente ya existe
            return
        }

        let newIngredient = Ingridient(context: viewContext)  // Crear un nuevo ingrediente en el contexto
        newIngredient.name = ingredientName
        newIngredient.quantity = ingredientQuantity
        ingredients.append(newIngredient)  // Añadir el ingrediente a la lista
        
        ingredientName = ""  // Limpiar el campo del nombre
        ingredientQuantity = ""  // Limpiar el campo de la cantidad
    }
    
    // Método para eliminar ingredientes de la lista
    private func deleteIngredient(at offsets: IndexSet) {
        for index in offsets {
            ingredients.remove(at: index)  // Remover el ingrediente de la lista
        }
    }
    
    // Método para guardar la nueva receta
    private func saveRecipe() {
        let newRecipe = Recipe(context: viewContext)  // Crear una nueva receta en el contexto
        newRecipe.title = title
        newRecipe.isFavorite = isFavorite
        newRecipe.ingredients = Set(ingredients)  // Asignar los ingredientes a la receta
        
        recipeStore.addRecipe(newRecipe)  // Añadir la receta a RecipeStore
    }
}
