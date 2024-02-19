//
//  Task+CoreDataProperties.swift
//  Dummy
//
//  Created by Alumne on 05/02/2024.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var creationAt: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var notes: String?
    @NSManaged public var title: String?
    @NSManaged public var list: TaskList?

}

extension Task : Identifiable {

}
