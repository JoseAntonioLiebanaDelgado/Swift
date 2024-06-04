//
//  Ingridient+CoreDataProperties.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 26/5/24.
//
//

import Foundation
import CoreData


extension Ingridient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingridient> {
        return NSFetchRequest<Ingridient>(entityName: "Ingridient")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: String?
    @NSManaged public var recipe: Recipe?

}

extension Ingridient : Identifiable {

}
