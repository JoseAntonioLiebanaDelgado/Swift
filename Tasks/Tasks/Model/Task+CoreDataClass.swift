// Importa las bibliotecas necesarias: Foundation y CoreData.
import Foundation
import CoreData

// Usa la anotación @objc para exponer esta clase a Objective-C, lo cual es necesario para Core Data.
// 'Task' es el nombre de la entidad en el modelo de datos de Core Data.
@objc(Task)
// Declara la clase 'Task' como pública para que pueda ser accesible fuera de su módulo, y hereda de 'NSManagedObject'.
public class Task: NSManagedObject {
    // Aquí normalmente irían las propiedades y métodos de la entidad 'Task'.
    // Pero en este caso, esas propiedades y métodos se han extendido en otro archivo (Task+CoreDataProperties.swift).
}
