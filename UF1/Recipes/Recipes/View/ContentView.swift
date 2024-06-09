import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext  // Contexto de Core Data desde el entorno
    @EnvironmentObject var recipeStore: RecipeStore  // Instancia de RecipeStore desde el entorno
    @State private var isShowingCreateModal = false  // Estado para controlar la presentación del modal de creación de recetas
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        // Iterar sobre las recetas en RecipeStore
                        ForEach(recipeStore.recipes, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                HStack {
                                    RecipeStatusView(isFavorite: recipe.isFavorite)  // Vista de estado de la receta (favorita o no)
                                    Text(recipe.title ?? "No Title")  // Título de la receta
                                    Spacer()
                                }
                            }
                        }
                        .onDelete(perform: deleteRecipes)  // Permitir eliminación de recetas 
                    }
                }
                .background(Color.white)
                .navigationBarTitle(Text("Recipes"))  // Título de la barra de navegación
                .navigationBarItems(trailing: Button(action: {
                    isShowingCreateModal = true  // Mostrar modal de creación al hacer clic en el botón "+"
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isShowingCreateModal) {
                    RecipeCreateView()
                        .environment(\.managedObjectContext, viewContext)  // Proveer el contexto al modal
                        .environmentObject(recipeStore)  // Proveer RecipeStore al modal
                }
            }
        }
    }
    
    // Método para eliminar recetas
    private func deleteRecipes(at offsets: IndexSet) {
        recipeStore.deleteRecipe(at: offsets)
    }
}
