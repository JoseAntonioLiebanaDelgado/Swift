
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var fruitStore: FruitStore
    @State private var isAddingFruit = false
    @State private var newFruit = FruitStore.defaultFruit

    var body: some View {
        NavigationView {
            List {
                ForEach(fruitStore.fruits) { fruit in
                    NavigationLink(destination: DetailFruitView(fruit: fruit)) {
                        FruitRowView(fruit: fruit)
                    }
                }
                .onDelete { indices in
                    fruitStore.fruits.remove(atOffsets: indices)
                }
            }
            .navigationBarTitle("Fruits")
            .navigationBarItems(
                trailing: Button(action: {
                    isAddingFruit = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isAddingFruit) {
                AddFruitView(newFruit: $newFruit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

