// Importa las bibliotecas necesarias para trabajar con Foundation y Core Data.
import Foundation
import CoreData

// TaskStore se declara como ObservableObject para que pueda ser observado por SwiftUI.
class TaskStore: ObservableObject {
    
    // Define una propiedad estática para acceder al contexto de Core Data.
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // Crea y configura el contenedor persistente de Core Data.
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                // Imprime un error si la carga del almacén persistente falla.
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    // Una lista publicada de tareas que se actualizará para reflejar los cambios en la UI.
    @Published var taskList=[Task]()
    
    // En el inicializador se carga la lista de tareas desde Core Data.
    init(){
        fetch()
    }
    
    // Guarda los cambios en el contexto de Core Data y recarga la lista de tareas.
    private func saveContext () {
        if TaskStore.context.hasChanges {
            do {
                try TaskStore.context.save()
                fetch()
            } catch {
                // Si hay un error al guardar, se produce un error fatal.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
  
    // Recupera las tareas desde Core Data y las asigna a taskList.
    private func fetch() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            self.taskList = try TaskStore.context.fetch(request)
        } catch {
            print("Could not fetch. \(error)")
        }
    }
    
    // Añade una nueva tarea a Core Data si no existe una con el mismo título.
    func addTask(title: String, notes: String, createdAt: Date, isDone: Bool) ->Bool{
        if !(filterTask(by: title) == nil) {
            return false
        } else {
            let task = Task(context: TaskStore.context)
            task.title = title
            task.notes = notes
            task.creationDate = createdAt
            task.isDone = isDone
            saveContext()
            return true
        }
    }
    
    // Filtra las tareas por título y devuelve la primera que coincide.
    func filterTask(by title: String) -> Task? {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try TaskStore.context.fetch(request)
            if results.isEmpty {
                return nil
            } else {
                return results[0]
            }
        } catch {
            print("Could not fetch. \(error)")
            return nil
        }
    }
    
    // Elimina tareas en las posiciones especificadas.
    func deleteTask(at offsets: IndexSet){
        for index in offsets {
            TaskStore.context.delete(taskList[index])
        }
        saveContext()
    }
    
    // Cambia el estado de completado de una tarea y guarda el cambio.
    func changeIsDoneTask(_ task: Task){
        task.isDone.toggle()
        saveContext()
    }
}
