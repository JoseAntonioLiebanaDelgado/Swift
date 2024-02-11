import Foundation
import CoreData


class TaskStore: ObservableObject {
    
    //private let container = NSPersistentContainer(name: "Tasks")
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    @Published var taskList=[Task]()
    
    init(){
        /*container.loadPersistentStores{desc, error in
            if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
            }
        }*/
        fetch()
    }
    
    private func saveContext () {
        //let context = container.viewContext
        if TaskStore.context.hasChanges {
            do {
                try TaskStore.context.save()
                fetch()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
  
    private func fetch() {
        let request:NSFetchRequest<Task> = Task.fetchRequest()
        do{
            self.taskList = try TaskStore.context.fetch(request)
        }catch{
            print("Could not fetch. \(error)")
            
        }
     }

    
 
    func addTask(title: String, notes: String, createdAt: Date, isDone: Bool) ->Bool{
        if !(filterTask(by: title) == nil) {
            return false
        }else {
            let task = Task(context: TaskStore.context)
            task.title = title
            task.notes = notes
            task.creationDate = createdAt
            task.isDone = isDone
            saveContext()
            return true
        }
    }
    
    func filterTask(by title:String)->Task?{
        let request:NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do{
            let results = try TaskStore.context.fetch(request)
            if results.isEmpty{
                return nil
            }else{
                return results[0]
            }
        }catch{
            print("Could not fetch. \(error)")
            return nil
        }
    }
    
    func deleteTask(at offsets: IndexSet){
        
        let context = TaskStore.context
        for index in offsets {
            context.delete(taskList[index])
        }
        saveContext()
    }
    
    func changeIsDoneTask(_ task:Task){
        task.isDone.toggle()
        saveContext()
    }
}
