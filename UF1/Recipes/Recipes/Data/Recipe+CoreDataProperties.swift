import Foundation
import CoreData

// Extensión de la clase Recipe para definir sus propiedades y métodos
extension Recipe {

    // Método para crear una solicitud de búsqueda de recetas
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    // Propiedades administradas de Core Data
    @NSManaged public var title: String?  // Título de la receta
    @NSManaged public var isFavorite: Bool  // Indicador de receta favorita
    @NSManaged public var ingredients: Set<Ingridient>?  // Relación con los ingredientes

    // Propiedad calculada para obtener los ingredientes como un array
    var ingredientsArray: [Ingridient] {
        let set = ingredients ?? []  // Convertir el set de ingredientes a array
        return Array(set)
    }
    
    // Método para agregar un ingrediente a la receta
    public func addToIngredients(_ ingredient: Ingridient) {
        self.mutableSetValue(forKey: "ingredients").add(ingredient)  // Añadir el ingrediente al set mutable
    }
}

// Extensión para hacer que Recipe sea identificable (conforme al protocolo Identifiable)
extension Recipe: Identifiable {

}
