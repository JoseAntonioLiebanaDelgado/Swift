//
//  RickyApiApp.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import SwiftUI

@main
struct RickyApiApp: App {
    @StateObject private var rickyMortinStore = RickyMortinStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(rickyMortinStore)
        }
    }
}
