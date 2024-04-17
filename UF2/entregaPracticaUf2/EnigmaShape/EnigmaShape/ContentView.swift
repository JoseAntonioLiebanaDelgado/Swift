//
//  ContentView.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameView()
            .tabItem {
                Image(systemName: "gamecontroller")
                Text("Jugar")
            }
            HistorialRondasView()
            .tabItem {
                Image(systemName: "doc.text.magnifyingglass")
                Text("Historial rondas")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameStore())
    }
}
