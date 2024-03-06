//
//  Ingredientes+CoreDataProperties.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 6/3/24.
//
//

import Foundation
import CoreData


extension Ingredientes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredientes> {
        return NSFetchRequest<Ingredientes>(entityName: "Ingredientes")
    }

    @NSManaged public var cantidad: Float
    @NSManaged public var nombre: String?
    @NSManaged public var ingredientesRecetas: NSSet?

}

// MARK: Generated accessors for ingredientesRecetas
extension Ingredientes {

    @objc(addIngredientesRecetasObject:)
    @NSManaged public func addToIngredientesRecetas(_ value: Recetas)

    @objc(removeIngredientesRecetasObject:)
    @NSManaged public func removeFromIngredientesRecetas(_ value: Recetas)

    @objc(addIngredientesRecetas:)
    @NSManaged public func addToIngredientesRecetas(_ values: NSSet)

    @objc(removeIngredientesRecetas:)
    @NSManaged public func removeFromIngredientesRecetas(_ values: NSSet)

}

extension Ingredientes : Identifiable {

}
