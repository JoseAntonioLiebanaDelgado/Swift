// Importa las bibliotecas necesarias para trabajar con Foundation y Core Data.
import Foundation
import CoreData

// Extiende la clase 'Task' que fue definida previamente.
extension Task {

    // Define una función de clase pública que no está expuesta a Objective-C. Esta función crea y devuelve una instancia de NSFetchRequest para la entidad 'Task', que se puede usar para recuperar instancias de 'Task' de Core Data.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    // Define una serie de propiedades que corresponden a los atributos de la entidad 'Task' en el modelo de datos de Core Data. Estas propiedades son administradas por Core Data y deben ser marcadas con @NSManaged.
    // 'title' es un String opcional que representa el título de la tarea.
    @NSManaged public var title: String?
    // 'notes' es un String opcional que representa las notas adicionales de la tarea.
    @NSManaged public var notes: String?
    // 'creationDate' es una Date opcional que representa la fecha en que se creó la tarea.
    @NSManaged public var creationDate: Date?
    // 'isDone' es un Bool que indica si la tarea ha sido completada.
    @NSManaged public var isDone: Bool

}

// Hace que la clase 'Task' cumpla con el protocolo 'Identifiable'. Esto es útil para SwiftUI, que requiere que los elementos en ciertas vistas, como List, sean identificables de forma única.
extension Task : Identifiable {

}
