// Importa el framework Foundation, que proporciona clases básicas y funcionalidades.
import Foundation

// Define una clase 'FruitStore' que se adhiere al protocolo 'ObservableObject'.
// Esto permite que las instancias de 'FruitStore' puedan ser observadas por las vistas de SwiftUI.
class FruitStore: ObservableObject {
    
    // Marca la propiedad 'fruits' como '@Published' lo que significa que cualquier cambio en 'fruits'
    // notificará a las vistas observadoras para que se actualicen.
    @Published var fruits = loadFruits()
    
    // Define un método estático 'loadFruits' que devuelve un arreglo de objetos 'Fruit'.
    // Al ser estático, este método pertenece a la clase misma y no a una instancia específica.
    static func loadFruits()->[Fruit] {
        // Este método retorna un arreglo predefinido de frutas proporcionado por 'defaultFruits'.
        return FruitStore.defaultFruits
    }
    
    // Define una propiedad estática 'defaultFruits' que contiene un arreglo con instancias de 'Fruit'.
    // Cada 'Fruit' se inicializa con un nombre, un emoji asociado y una descripción.
    static let defaultFruits = [
        Fruit(name: "Apple", emoji: .apple, description: "Apples help your body develop resistance against infections"),
        Fruit(name: "Pineapple", emoji: .pineapple, description: "Pineapples help fight arthritis"),
        Fruit(name: "Watermelon", emoji: .watermelon, description: "Watermelon helps control your heart rate"),
    ]
    
    // Define una propiedad estática 'defaultFruit' que contiene una instancia por defecto de 'Fruit',
    // que en este caso es una sandía con su nombre, emoji y descripción.
    static let defaultFruit = Fruit(name: "Watermelon", emoji: .watermelon, description: "Watermelon helps control your heart rate")
}
