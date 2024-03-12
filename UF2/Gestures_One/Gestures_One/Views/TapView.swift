//
//  TapView.swift
//  Gestures_One
//
//  Created by Jose Antonio Liebana Delgado on 6/3/24.
//


import SwiftUI

// Define una estructura llamada TapView, que conforma al protocolo View, permitiéndole ser una parte de la interfaz de usuario.
struct TapView: View {

    // @State es un property wrapper que permite a la propiedad 'color' tener un estado mutable que, cuando cambia, hace que la vista se actualice.
    @State private var color : Color = Color.primary
    
    // Define una propiedad computada 'tapGesture' que retorna un gesto. Este gesto cambia el color de la vista cuando se detecta un toque.
    var tapGesture: some Gesture {
        TapGesture()
            // 'onEnded' se llama cuando el gesto de toque termina. Aquí se cambia el color de la vista de forma animada.
            .onEnded {
                withAnimation {
                    color = Color.random()
                }
            }
    }
    
    // La propiedad computada 'body' define el contenido de la vista y su layout.
    var body: some View {
        // VStack organiza sus vistas hijo verticalmente.
        VStack {
            // Crea un objeto de texto que indica al usuario que toque el rectángulo para cambiar su color.
            Text("Tap the rectangle to change its color")
            // Spacer crea un espacio flexible que se expande para llenar el espacio vertical disponible.
            Spacer()
            // Crea un rectángulo que utiliza el color almacenado en la propiedad 'color'.
            Rectangle()
                // Aplica el color de primer plano al rectángulo.
                .foregroundColor(color)
                // Define el tamaño del rectángulo.
                .frame(width: 250, height: 450)
                // Vincula el gesto de toque definido en 'tapGesture' al rectángulo.
                .gesture(tapGesture)
            // Otro Spacer para crear espacio después del rectángulo.
            Spacer()
        }
        // Establece el título de la navegación para esta vista.
        .navigationTitle("Tap")
        // Aplica un padding alrededor del VStack.
        .padding()
        // Define una barra de herramientas con un botón que restablece el color del rectángulo al color primario cuando se presiona.
        .toolbar {
            Button("Reset") {
                color = Color.primary
            }
        }
    }
}

// Proporciona una vista previa de TapView dentro del editor de Xcode.
struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}

// Extiende la estructura Color con un método estático que genera un color aleatorio.
extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
