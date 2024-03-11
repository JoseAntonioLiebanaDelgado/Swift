//
//  RecipeStore.swift
//  CookingRecipes
//
//  Created by Jose Antonio Liebana Delgado on 11/3/24.
//

import Foundation
import CoreData


class RecipeStore: ObservableObject {
    
    //private let container = NSPersistentContainer(name: "Tasks")
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Recipes")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    @Published var recipeList=[Recetas]()
    
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
        if RecipeStore.context.hasChanges {
            do {
                try RecipeStore.context.save()
                fetch()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
  
    private func fetch() {
        let request:NSFetchRequest<Recetas> = Recetas.fetchRequest()
        do{
            self.recipeList = try RecipeStore.context.fetch(request)
        }catch{
            print("Could not fetch. \(error)")
            
        }
     }

    func addRecipe(nombre: String, descripcion: String, instrucciones: String, cantidad: Float ,imagen: String ,esFavorito: Bool) ->Bool{
        if !(filterRecipe(by: nombre) == nil) {
            return false
        }else {
            let recipe = Recetas(context: RecipeStore.context)
            recipe.nombre = nombre
            recipe.descripcion = descripcion
            recipe.instrucciones = instrucciones
            recipe.cantidad = cantidad
            recipe.imagen = imagen
            recipe.esFavorito = esFavorito
            //recipe.recetaIngredientes = recetaIngredientes
            saveContext()
            return true
        }
    }
    
    func filterRecipe(by title:String)->Recetas?{
        let request:NSFetchRequest<Recetas> = Recetas.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do{
            let results = try RecipeStore.context.fetch(request)
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
    
    func deleteRecipe(at offsets: IndexSet){
        
        let context = RecipeStore.context
        for index in offsets {
            context.delete(recipeList[index])
        }
        saveContext()
    }
    
    func changeIsDoneRecipe(_ recipe:Recetas){
        recipe.esFavorito.toggle()
        saveContext()
    }
}
