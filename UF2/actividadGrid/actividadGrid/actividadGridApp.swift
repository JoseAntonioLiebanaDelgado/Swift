//
//  actividadGridApp.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import SwiftUI

@main
struct actividadGridApp: App {
    @StateObject private var flickrPhotoStore = FlickrPhotoStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(flickrPhotoStore)
        }
    }
}
