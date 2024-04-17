//
//  EnigmaShapeApp.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

@main
struct EnigmaShapeApp: App {
    @StateObject private var gameStore = GameStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(gameStore)
        }
    }
}
