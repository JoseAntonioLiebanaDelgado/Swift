import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var recipeStore: RecipeStore
    
    @State private var isShowingCreateModal = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ForEach(recipeStore.recipes, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                HStack {
                                    RecipeStatusView(isFavorite: recipe.isFavorite)
                                    Text(recipe.title ?? "No Title")
                                    Spacer()
                                }
                            }
                        }
                        .onDelete(perform: deleteRecipes) 
                    }
                }
                .background(Color.white)
                .navigationBarTitle(Text("Recipes"))
                .navigationBarItems(trailing: Button(action: {
                    isShowingCreateModal = true
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $isShowingCreateModal) {
                    RecipeCreateView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(recipeStore)
                }
            }
        }
    }
    
    private func deleteRecipes(at offsets: IndexSet) {
        recipeStore.deleteRecipe(at: offsets)
    }
}
