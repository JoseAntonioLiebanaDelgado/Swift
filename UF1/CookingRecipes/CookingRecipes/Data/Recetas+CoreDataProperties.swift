//
//  Recetas+CoreDataProperties.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 6/3/24.
//
//

import Foundation
import CoreData


extension Recetas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recetas> {
        return NSFetchRequest<Recetas>(entityName: "Recetas")
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var esFavorito: Bool
    @NSManaged public var imagen: String?
    @NSManaged public var instrucciones: String?
    @NSManaged public var nombre: String?
    @NSManaged public var recetaIngredientes: NSSet?

}

// MARK: Generated accessors for recetaIngredientes
extension Recetas {

    @objc(addRecetaIngredientesObject:)
    @NSManaged public func addToRecetaIngredientes(_ value: Ingredientes)

    @objc(removeRecetaIngredientesObject:)
    @NSManaged public func removeFromRecetaIngredientes(_ value: Ingredientes)

    @objc(addRecetaIngredientes:)
    @NSManaged public func addToRecetaIngredientes(_ values: NSSet)

    @objc(removeRecetaIngredientes:)
    @NSManaged public func removeFromRecetaIngredientes(_ values: NSSet)

}

extension Recetas : Identifiable {

}
