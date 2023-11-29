import SwiftUI

@main
struct FruitsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FruitStore())
        }
    }
}
