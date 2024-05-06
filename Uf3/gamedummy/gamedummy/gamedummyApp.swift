//
//  gamedummyApp.swift
//  gamedummy
//
//  Created by alumne on 10/04/2024.
//

import SwiftUI

@main
struct gamedummyApp: App {
    @StateObject var viewModel = ViewStoreModel()
    
    var body: some Scene {
        WindowGroup{
            ContentView().environmentObject(viewModel)
        }
    }
}
