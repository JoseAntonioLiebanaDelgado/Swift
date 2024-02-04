//
//  RickyApiApp.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import SwiftUI 

// Anota la estructura con @main, indicando que es el punto de entrada de la aplicación.
@main
struct RickyApiApp: App {
    // Crea una instancia de RickyMortinStore y la anota con @StateObject, lo que indica que es un objeto de estado para esta app y se creará solo una vez durante la vida útil de la app.
    @StateObject private var rickyMortinStore = RickyMortinStore()
    
    // Define el cuerpo de la app, que describe el contenido de la escena de la app.
    var body: some Scene {
        WindowGroup {
            // Crea la vista de contenido principal y le inyecta el rickyMortinStore como un EnvironmentObject.
            ContentView().environmentObject(rickyMortinStore)
        }
    }
}

