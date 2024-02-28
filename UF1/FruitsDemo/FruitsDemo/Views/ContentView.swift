// Importa el framework SwiftUI para construir la interfaz de usuario.
import SwiftUI

// Define la estructura ContentView, que conforma al protocolo View de SwiftUI.
struct ContentView: View {
    
    // Declara un objeto de entorno 'fruitStore' para acceder a los datos de las frutas.
    @EnvironmentObject private var fruitStore: FruitStore
    
    // Mantiene el estado de si se está añadiendo una nueva fruta o no.
    @State private var isAddingFruit = false
    
    // Mantiene el estado de la nueva fruta a añadir, inicializada con un valor predeterminado.
    @State private var newFruit = FruitStore.defaultFruit

    // Define el cuerpo de la vista ContentView.
    var body: some View {
        // Crea una vista de navegación para permitir la navegación entre vistas.
        NavigationView {
            // Lista las frutas disponibles en 'fruitStore'.
            List {
                // Itera sobre cada fruta en 'fruitStore.fruits', creando una vista por cada una.
                ForEach(fruitStore.fruits) { fruit in
                    // Crea un enlace de navegación para cada fruta, dirigiendo a DetailFruitView cuando se selecciona.
                    NavigationLink(destination: DetailFruitView(fruit: fruit)) {
                        // Utiliza FruitRowView para mostrar la información de cada fruta en una fila.
                        FruitRowView(fruit: fruit)
                    }
                }
                // Añade la capacidad de eliminar frutas deslizando para borrar.
                .onDelete { indices in
                    // Elimina las frutas seleccionadas de 'fruitStore.fruits'.
                    fruitStore.fruits.remove(atOffsets: indices)
                }
            }
            // Establece el título de la barra de navegación.
            .navigationBarTitle("Fruits")
            // Añade un botón a la barra de navegación para añadir nuevas frutas.
            .navigationBarItems(
                trailing: Button(action: {
                    // Cambia el estado de 'isAddingFruit' a true, lo que muestra la hoja para añadir una fruta.
                    isAddingFruit = true
                }) {
                    // El botón muestra un icono de suma.
                    Image(systemName: "plus")
                }
            )
            // Muestra una hoja cuando 'isAddingFruit' es true, permitiendo añadir una nueva fruta.
            .sheet(isPresented: $isAddingFruit) {
                // La hoja mostrada es AddFruitView, pasando 'newFruit' como un binding.
                AddFruitView(newFruit: $newFruit)
            }
        }
    }
}

// Define una vista previa para ContentView.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra ContentView en el modo de vista previa.
        ContentView()
    }
}
