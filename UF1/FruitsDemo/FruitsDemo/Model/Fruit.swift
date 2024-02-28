// Importa el framework Foundation, que proporciona clases y funcionalidades básicas.
import Foundation

// Define una estructura 'Fruit' que cumple con los protocolos 'Hashable' e 'Identifiable'.
// Las instancias de Fruit pueden ser utilizadas en colecciones que requieren hashing (como Set o como claves en Dictionary).
// Cada Fruit puede ser identificado de manera única (necesario para SwiftUI cuando se manejan colecciones de datos en la UI).

/*La Diferencia:
 
Hashable es como el código de barras: ayuda a identificar rápidamente el tipo de producto en una colección grande (como un supermercado) pero no es imposible (aunque sí muy raro) que dos productos diferentes tengan el mismo código.
Identifiable es como el número de serie: asegura que cada dispositivo sea único y rastreable individualmente, sin posibilidad de duplicados.
Entonces, en el contexto de tu aplicación, si tienes una lista de frutas:

Hashable permite que Swift sepa si una fruta ya está en una colección o no, basándose en su "código de barras" (valor hash).
Identifiable permite que SwiftUI mantenga un seguimiento de cada fruta individual en una lista de UI, usando su "número de serie" (id), asegurando que las operaciones como eliminar o mover frutas en la lista se hagan en la fruta correcta.*/

struct Fruit: Hashable, Identifiable {
    
    // Define una propiedad 'id' que es única para cada instancia de 'Fruit'.
    // Aquí hay un error: 'some Hashable{name}' no es una sintaxis válida para definir una propiedad 'id'.
    // Probablemente se pretendía usar 'var id = UUID()' para generar un identificador único o simplemente 'var id: String { name }'.
    var id: some Hashable{name}
    
    // Define una propiedad 'name' de tipo 'String' para almacenar el nombre de la fruta.
    var name: String
    
    // Define una propiedad 'emoji' de tipo 'EmojiFruit' para almacenar el emoji asociado con la fruta.
    var emoji: EmojiFruit
    
    // Define una propiedad 'description' de tipo 'String' para almacenar una descripción de la fruta.
    var description: String
}

// Define un 'enum' llamado 'EmojiFruit' que hereda de 'String' y cumple con el protocolo 'CaseIterable'.
enum EmojiFruit: String, CaseIterable {
    // Define casos para diferentes frutas, donde cada caso tiene asociado un valor de tipo 'String' que representa un emoji.
    case apple = "🍎"
    case banana = "🍌"
    case coco = "🥥"
    case grape = "🍇"
    case kiwi = "🥝"
    case lemon = "🍋"
    case orange = "🍊"
    case pear = "🍐"
    case pineapple = "🍍"
    case strawberry = "🍓"
    case watermelon = "🍉"
}
