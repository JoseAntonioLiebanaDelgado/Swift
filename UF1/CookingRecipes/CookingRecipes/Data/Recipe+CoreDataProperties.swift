//
//  Recipe+CoreDataProperties.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 26/5/24.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var ingredients: Ingridient?

}

extension Recipe : Identifiable {

}
