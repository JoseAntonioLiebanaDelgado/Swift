import SwiftUI

@main
struct TasksApp: App {
    @StateObject var taskStore = TaskStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(taskStore)
        }
    }
}
