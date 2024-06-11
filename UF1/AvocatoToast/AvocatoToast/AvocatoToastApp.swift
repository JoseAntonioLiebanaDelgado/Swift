import SwiftUI

@main
struct AvocatoToastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(OrderStore()) // Proveer el OrderStore al entorno
        }
    }
}
