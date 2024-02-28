//
//  TaskStore.swift
//  Dummy
//
//  Created by Alumne on 05/02/2024.
//

import Foundation
import CoreData

class TaskStore: ObservableObject{
    
    @Published var selectedList:TaskList?
    
    func updateSelectList(_ list:TaskList){
        self.selectedList = list
    }
    
    func updateIsDoneinTask(_ task:Task, with value:Bool, context:NSManagedObjectContext){
        task.isDone = value
        do{
         try context.save()
        }catch{
            print("Error update is done in task \(error)")
        }
    }
    
    func addNewTaskList(name:String, context: NSManagedObjectContext)->Bool{
        let newTaskList = TaskList(context: context)
        newTaskList.name = name
        do{
         try context.save()
        }catch{
            print("Error saving tasklist \(error)")
        }
        return true
    }
    
    func addNewTask(title:String, notes:String, isDone:Bool, createdAt:Date, list:TaskList, context: NSManagedObjectContext)->Bool{
        
        let newTask = Task(context: context)
        newTask.title = title
        newTask.notes = notes
        newTask.creationAt = createdAt
        newTask.isDone = isDone
        newTask.list = list
        do{
         try context.save()
        }catch{
            print("Error saving tasklist \(error)")
        }
        
        return true
    }
}
