//
//  ContentView.swift
//  Gestures_One
//
//  Created by Jose Antonio Liebana Delgado on 6/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            //LLamar a la vista
            TapView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
