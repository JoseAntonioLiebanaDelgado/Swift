// Importa el framework SwiftUI para construir la interfaz de usuario.
import SwiftUI

// Define la estructura FruitRowView, que conforma al protocolo View de SwiftUI.
struct FruitRowView: View {
    // Declara una propiedad constante 'fruit' del tipo 'Fruit' para almacenar la información de la fruta que se mostrará.
    let fruit: Fruit
    
    // Define el cuerpo de la vista FruitRowView.
    var body: some View {
        // Crea un HStack, que organiza las vistas horizontalmente.
        HStack {
            // Muestra el emoji de la fruta. 'rawValue' se utiliza para acceder al valor String del emoji desde el enum.
            Text(fruit.emoji.rawValue)
            // Muestra el nombre de la fruta junto a su emoji.
            Text(fruit.name)
        }
    }
}

// Define una vista previa para FruitRowView.
struct FruitRowView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra FruitRowView en el modo de vista previa con una fruta predeterminada de FruitStore.
        FruitRowView(fruit: FruitStore.defaultFruit)
            // Aplica un layout de vista previa que ajusta el tamaño de la vista al contenido.
            .previewLayout(.sizeThatFits)
    }
}
