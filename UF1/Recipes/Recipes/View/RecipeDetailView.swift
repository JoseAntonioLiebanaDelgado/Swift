import SwiftUI

// Vista para mostrar y editar los detalles de una receta
struct RecipeDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext  // Contexto de Core Data desde el entorno
    @ObservedObject var recipe: Recipe  // Objeto observado para la receta

    @State private var newIngredientName = ""  // Estado para el nombre del nuevo ingrediente
    @State private var newIngredientQuantity = ""  // Estado para la cantidad del nuevo ingrediente
    
    var body: some View {
        VStack {
            // Campo para editar el título de la receta
            TextField("Title", text: Binding($recipe.title, ""))
                .font(.largeTitle)
                .padding()

            // Toggle para marcar como favorita la receta
            Toggle(isOn: Binding(
                get: { recipe.isFavorite },
                set: { recipe.isFavorite = $0 }
            )) {
                Text("Favorite")
            }
            .padding()

            List {
                // Sección para los ingredientes
                Section(header: Text("Ingredients")) {
                    // Iterar sobre los ingredientes de la receta
                    ForEach(recipe.ingredientsArray, id: \.self) { ingredient in
                        HStack {
                            // Campo para editar el nombre del ingrediente
                            TextField("Name", text: Binding(
                                get: { ingredient.name ?? "Unnamed Ingredient" },
                                set: { ingredient.name = $0 }
                            ))
                            Spacer()
                            // Campo para editar la cantidad del ingrediente
                            TextField("Quantity", text: Binding(
                                get: { ingredient.quantity ?? "" },
                                set: { ingredient.quantity = $0 }
                            ))
                        }
                    }
                    .onDelete(perform: deleteIngredient)  // Permitir eliminación de ingredientes
                    
                    HStack {
                        // Campo para añadir un nuevo ingrediente
                        TextField("New Ingredient Name", text: $newIngredientName)
                        TextField("Quantity", text: $newIngredientQuantity)
                        Button(action: addIngredient) {
                            Text("Add")  // Botón para agregar ingrediente
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(recipe.title ?? "Recipe Details"), displayMode: .inline)  // Título de la barra de navegación
        .navigationBarItems(trailing: Button(action: saveChanges) {
            Text("Save")  // Botón para guardar cambios
        })
    }
    
    // Método para agregar un nuevo ingrediente a la receta
    private func addIngredient() {
        guard !newIngredientName.isEmpty else { return }  // Verificar que el nombre del ingrediente no esté vacío
        
        if recipe.ingredientsArray.contains(where: { $0.name?.lowercased() == newIngredientName.lowercased() }) {
            print("Ingredient with this name already exists.")  // Verificar si el ingrediente ya existe
            return
        }

        let newIngredient = Ingridient(context: viewContext)  // Crear un nuevo ingrediente en el contexto
        newIngredient.name = newIngredientName
        newIngredient.quantity = newIngredientQuantity
        newIngredient.recipe = recipe
        recipe.addToIngredients(newIngredient)  // Añadir el ingrediente a la receta
        
        newIngredientName = ""  // Limpiar el campo del nombre
        newIngredientQuantity = ""  // Limpiar el campo de la cantidad
    }
    
    // Método para eliminar ingredientes de la receta
    private func deleteIngredient(at offsets: IndexSet) {
        for index in offsets {
            let ingredient = recipe.ingredientsArray[index]  // Obtener el ingrediente por índice
            viewContext.delete(ingredient)  // Eliminar el ingrediente del contexto
        }
        saveChanges()  // Guardar los cambios en el contexto
    }
    
    // Método para guardar los cambios en el contexto de Core Data
    private func saveChanges() {
        do {
            try viewContext.save()  // Intentar guardar el contexto
        } catch {
            print("Error saving context: \(error.localizedDescription)")  // Manejar errores de guardado
        }
    }
}

// Extensión para inicializar un Binding con un valor por defecto
extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) where Value: Equatable {
        self.init(
            get: { source.wrappedValue ?? defaultValue },  // Obtener el valor o el valor por defecto
            set: { newValue in source.wrappedValue = newValue }  // Establecer el nuevo valor
        )
    }
}
