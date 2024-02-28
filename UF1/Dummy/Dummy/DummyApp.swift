import SwiftUI

@main
struct DummyApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var taskStore = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskStore)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
