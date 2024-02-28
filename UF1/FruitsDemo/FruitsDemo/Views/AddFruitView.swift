// Importa el framework SwiftUI para construir la interfaz de usuario.
import SwiftUI

// Define la estructura 'AddFruitView' que conforma al protocolo 'View'.
struct AddFruitView: View {
    
    // Usa '@Binding' para crear una conexión bidireccional con la propiedad que almacena la nueva fruta a añadir.
    @Binding var newFruit: Fruit
    // Accede al 'presentationMode' del entorno para controlar la presentación de esta vista.
    @Environment(\.presentationMode) var presentationMode
    // Declara un objeto de entorno 'fruitStore' para acceder y modificar los datos de las frutas.
    @EnvironmentObject private var fruitStore: FruitStore
    
    // Define el cuerpo de la vista 'AddFruitView'.
    var body: some View {
        // Crea una vista de navegación.
        NavigationView {
            // Utiliza un formulario para agrupar los controles de entrada de datos.
            Form {
                // Sección para introducir el nombre de la nueva fruta.
                Section(header: Text("Name")) {
                    TextField("Name", text: $newFruit.name)
                }
                // Sección para introducir la descripción de la nueva fruta.
                Section(header: Text("Description")) {
                    TextEditor(text: $newFruit.description)
                }
                // Sección para seleccionar el emoji de la nueva fruta.
                Section(header: Text("Image")) {
                    EmojiPicker(emoji: $newFruit.emoji)
                }
            }
            // Establece el título de la barra de navegación.
            .navigationBarTitle("Add Fruit")
            // Añade botones para cancelar y guardar la nueva fruta.
            .navigationBarItems(
                leading: Button("Cancelar") {
                    // Cierra la vista cuando se toca 'Cancelar'.
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Guardar") {
                    // Llama a 'addFruit()' para guardar la nueva fruta y luego cierra la vista.
                    addFruit()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    // Función para añadir la nueva fruta a 'fruitStore'.
    func addFruit() {
        fruitStore.fruits.append(newFruit)
    }
}

// Define una vista previa para 'AddFruitView'.
struct AddFruitView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra 'AddFruitView' en modo de vista previa con valores predeterminados.
        AddFruitView(newFruit: .constant(FruitStore.defaultFruit))
        // Muestra 'AddFruitView' en modo oscuro.
        AddFruitView(newFruit: .constant(FruitStore.defaultFruit))
            .preferredColorScheme(.dark)
        // Muestra 'AddFruitView' con un layout fijo.
        AddFruitView(newFruit: .constant(FruitStore.defaultFruit))
            .previewLayout(.fixed(width: 480, height: 320))
    }
}
