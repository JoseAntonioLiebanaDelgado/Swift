//
//  Test2CoredataApp.swift
//  Test2Coredata
//
//  Created by Jose Antonio Liebana Delgado on 3/6/24.
//

import SwiftUI

@main
struct Test2CoredataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
