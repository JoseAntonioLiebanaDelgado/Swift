import Foundation
import CoreData

// Extensión de la clase Ingridient para definir sus propiedades y métodos
extension Ingridient {

    // Método para crear una solicitud de búsqueda de ingredientes
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingridient> {
        return NSFetchRequest<Ingridient>(entityName: "Ingridient")
    }

    // Propiedades administradas de Core Data
    @NSManaged public var name: String?  // Nombre del ingrediente
    @NSManaged public var quantity: String?  // Cantidad del ingrediente
    @NSManaged public var recipe: Recipe?  // Relación con la receta a la que pertenece

}

// Extensión para hacer que Ingridient sea identificable (conforme al protocolo Identifiable)
extension Ingridient: Identifiable {

}
