//
//  Task+CoreDataProperties.swift
//  Tasks
//
//  Created by Alumne on 31/01/2024.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var notes: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var isDone: Bool

}

extension Task : Identifiable {

}
