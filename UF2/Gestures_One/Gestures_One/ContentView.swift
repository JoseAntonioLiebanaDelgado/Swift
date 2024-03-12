//
//  ContentView.swift
//  Gestures_One
//
//  Created by Jose Antonio Liebana Delgado on 6/3/24.
//

import SwiftUI

// Define una estructura llamada `ContentView` que es una vista en SwiftUI.
struct ContentView: View {
    // La propiedad `body` define el contenido de la vista.
    var body: some View {
        // `VStack` organiza sus vistas hijas en una columna vertical.
        VStack {
            // Crea una imagen usando un nombre de sistema "globe" y ajusta su tamaño y estilo.
            Image(systemName: "globe")
                .imageScale(.large) // Ajusta el tamaño de la imagen a grande.
                .foregroundStyle(.tint) // Aplica el color de tinte principal a la imagen.
            // Crea un texto que muestra "Hello, world!".
            Text("Hello, world!")
            // Llama a otra vista personalizada `TapView` y la incluye en la pila vertical.
            TapView() // Llamar a la vista `TapView`.
        }
        .padding() // Aplica relleno alrededor de la pila vertical (`VStack`).
    }
}

// Define una estructura para previsualizar `ContentView` en Xcode.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Muestra una previsualización de `ContentView`.
    }
}
