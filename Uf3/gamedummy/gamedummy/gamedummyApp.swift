//
//  gamedummyApp.swift
//  gamedummy
//
//  Created by alumne on 10/04/2024.
//

import SwiftUI

// Indica el punto de entrada principal de la aplicación.
@main
struct gamedummyApp: App {
    // Declara un objeto observable que contiene el estado compartido de la aplicación.
    @StateObject var viewModel = ViewStoreModel()
    
    // Cuerpo que define una o más escenas.
    var body: some Scene {
        WindowGroup{
            // Crea una instancia de 'ContentView' y le pasa el objeto observable como 'EnvironmentObject'.
            ContentView().environmentObject(viewModel)
        }
    }
}
