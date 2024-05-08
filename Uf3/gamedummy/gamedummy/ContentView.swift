//
//  ContentView.swift
//  gamedummy
//
//  Created by alumne on 10/04/2024.
//

import SwiftUI

// Define una estructura que conforma el protocolo 'View'.
struct ContentView: View {
    // Declara una propiedad que proporciona acceso al objeto observable compartido en el entorno de la aplicación.
    @EnvironmentObject var viewModel: ViewStoreModel
    
    // Declara una propiedad que devuelve un gesto de arrastre.
    var dragGesture: some Gesture {
        DragGesture().onChanged() { value in
            // Actualiza la propiedad 'center' del modelo con la ubicación actual del gesto de arrastre.
            self.viewModel.center = value.location
        }
    }
    
    // Cuerpo que define la interfaz de usuario.
    var body: some View {
        // Componente que proporciona acceso a las dimensiones de su contenedor.
        GeometryReader { geometry in
            ZStack {
                // Apila vistas una encima de la otra.
                Circle()
                    // Crea una vista de círculo.
                    .fill(Color.red)
                    // Rellena el círculo con color rojo.
                    .frame(width: 50, height: 50)
                    // Establece el tamaño del círculo.
                    .position(viewModel.center)
                    // Posiciona el círculo según las coordenadas del 'ViewStoreModel'.
                    .gesture(dragGesture)
                    // Asigna el gesto de arrastre al círculo.
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            // Establece el tamaño mínimo y máximo del contenedor.
            .background(Color.black)
            // Establece el color de fondo negro.
            .edgesIgnoringSafeArea(.all)
            // Permite que el fondo se extienda a las áreas seguras.
            .onAppear() {
                // Define una acción que se ejecuta cuando la vista aparece.
                viewModel.center.x = geometry.size.width / 2
                // Establece la posición horizontal inicial en el centro.
                viewModel.center.y = geometry.size.height - 20
                // Establece la posición vertical inicial cerca del fondo.
                viewModel.createDisplayLink()
                // Llama a un método para crear un 'display link'.
            }
        }
    }
}

// Proporciona una vista de previsualización para el entorno de desarrollo.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Define el contenido de la vista de previsualización.
        ContentView()
    }
}
