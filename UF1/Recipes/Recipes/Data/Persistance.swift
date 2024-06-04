import CoreData

struct PersistenceController {
    // Singleton para acceder a una única instancia de PersistenceController.
    static let shared = PersistenceController()

    // Instancia para previsualización, configurada para usar almacenamiento en memoria.
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Creación de una receta de ejemplo y sus ingredientes.
        let newRecipe = Recipe(context: viewContext)
        newRecipe.title = "Spaghetti Bolognese"
        newRecipe.isFavorite = true
        
        let ingredient1 = Ingridient(context: viewContext)
        ingredient1.name = "Spaghetti"
        ingredient1.quantity = "200g"
        ingredient1.recipe = newRecipe
        
        let ingredient2 = Ingridient(context: viewContext)
        ingredient2.name = "Minced Meat"
        ingredient2.quantity = "100g"
        ingredient2.recipe = newRecipe
        
        newRecipe.ingredients = [ingredient1, ingredient2]

        do {
            // Intento de guardar el contexto con los datos de ejemplo.
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // NSPersistentContainer maneja el almacenamiento persistente de Core Data.
    let container: NSPersistentContainer

    // Inicializador que configura el contenedor persistente.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            // Configuración para usar almacenamiento en memoria, útil para pruebas.
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        if !inMemory {
            // Carga de datos de prueba si no está en modo de memoria.
            loadDummyData()
        }
    }
    
    // Carga de datos de prueba en el contexto de Core Data.
    private func loadDummyData() {
        let viewContext = container.viewContext
        
        let newRecipe = Recipe(context: viewContext)
        newRecipe.title = "Spaghetti Bolognese"
        newRecipe.isFavorite = true
        
        let ingredient1 = Ingridient(context: viewContext)
        ingredient1.name = "Spaghetti"
        ingredient1.quantity = "200g"
        ingredient1.recipe = newRecipe
        
        let ingredient2 = Ingridient(context: viewContext)
        ingredient2.name = "Minced Meat"
        ingredient2.quantity = "100g"
        ingredient2.recipe = newRecipe
        
        newRecipe.ingredients = [ingredient1, ingredient2]

        do {
            // Intento de guardar el contexto con los datos de prueba.
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
