import Foundation
import CoreData


class TaskStore: ObservableObject {
 
    private let container = NSPersistentContainer(name: "Tasks")
    
    
    @Published var taskList=[Task]()
    
    init(){
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
        fetch()
    }
    
    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                fetch()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
  
    func fetch() {
         // MARK: TO DO
        let request:NSFetchRequest<Task> = Task.fetchRequest()

        do{
        self.taskList = try container.viewContext.fetch(request)
        }catch{
            print("Could not fetch. \(error)")
            
        }
     }
    
 
    func addTask(title: String, notes: String, createdAt: Date, isDone: Bool) ->Bool{
        // MARK: TO DO
        let task = Task(context: container.viewContext)
        task.title = title
        task.notes = notes
        task.creationDate = createdAt
        task.isDone = isDone
        saveContext()
        
        print(" cantidad de tareas \(self.taskList.count)")
        return true
    }
    
    func deleteTask(at offsets: IndexSet){
        
        let context = container.viewContext
        for index in offsets {
            // MARK: TO DO
            context.delete(taskList[index])
        }
        saveContext()
    }
}
