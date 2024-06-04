import Foundation
import CoreData

extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var ingredients: Set<Ingridient>?
    
    var ingredientsArray: [Ingridient] {
        let set = ingredients as? Set<Ingridient> ?? []
        return Array(set)
    }
    
    public func addToIngredients(_ ingredient: Ingridient) {
        self.mutableSetValue(forKey: "ingredients").add(ingredient)
    }
}

extension Recipe: Identifiable {

}
