import CoreData

// Controlador de persistencia para manejar Core Data
struct PersistenceController {
    static let shared = PersistenceController()  // Instancia compartida

    // Configuración para vista previa con datos en memoria
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)  // Inicializar con datos en memoria
        let viewContext = result.container.viewContext

        // Crear datos de ejemplo
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

        // Guardar el contexto
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer  // Contenedor de Core Data

    // Inicializador del controlador de persistencia
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")  // Configurar para almacenar en memoria
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")  // Manejar errores de carga
            }
        })
        if !inMemory {
            loadDummyData()  // Cargar datos de ejemplo si no está en memoria
        }
    }
    
    // Método privado para cargar datos de ejemplo
    private func loadDummyData() {
        let viewContext = container.viewContext
        
        if !isRecipeExists(title: "Spaghetti Bolognese", context: viewContext) {
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

            // Guardar el contexto
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // Método privado para verificar si una receta ya existe
    private func isRecipeExists(title: String, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)

        do {
            let matchingRecipes = try context.fetch(request)  // Ejecutar solicitud de búsqueda
            return !matchingRecipes.isEmpty  // Verificar si hay recetas coincidentes
        } catch {
            print("Error checking for existing recipe: \(error)")  // Manejar errores de búsqueda
            return false
        }
    }
}
