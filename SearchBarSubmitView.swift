//
//  SearchBarSubmitView.swift
//  CoinMarket
//
//  Created by José Antonio Liebana on 27/01/2024.
//

import SwiftUI // Importa el framework SwiftUI para construir la interfaz de usuario.

// Define una estructura SearchBarSubmitView que conforma al protocolo View, representando una vista en SwiftUI.
struct SearchBarSubmitView: View {
    // Declara una variable para el texto de marcador de posición de la barra de búsqueda.
    var placeholder: String
    // Usa @Binding para crear una conexión bidireccional con una variable String externa, permitiendo leer y modificar el texto.
    @Binding var text: String
    // Usa @Binding para crear una conexión bidireccional con una variable Bool externa, permitiendo leer y modificar el estado de envío.
    @Binding var submit: Bool
    
    // Define el cuerpo de la vista.
    var body: some View {
        // Organiza los elementos horizontalmente usando HStack.
        HStack {
            // Muestra un icono de lupa.
            Image(systemName: "magnifyingglass")
                .imageScale(.medium) // Establece el tamaño de la imagen.
                .foregroundColor(Color(.systemGray3)) // Establece el color de la imagen.
            
            // Crea un campo de texto para la entrada del usuario.
            TextField(placeholder, text: $text, onCommit: { submit.toggle() })
            // Ejecuta la acción de envío cuando el usuario presiona el botón de retorno.
            
            // Muestra un botón de cancelar si el texto no está vacío.
            if !text.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium) // Establece el tamaño de la imagen.
                    .foregroundColor(Color(.systemGray3)) // Establece el color de la imagen.
                    
                    // Añade un gesto de toque que limpia el campo de texto.
                    .onTapGesture {
                        withAnimation {
                            self.text = "" // Limpia el texto.
                        }
                    }
            }
        }
        .padding(8) // Añade un relleno alrededor del HStack.
        // Añade un borde redondeado alrededor del HStack.
        .overlay(RoundedRectangle(cornerRadius: 25.0).stroke())
        .foregroundColor(Color.gray) // Establece el color del borde.
    }
}

// Proporciona una vista previa de SearchBarSubmitView para el diseñador de interfaces de Xcode.
struct SearchBarSubmitView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra la vista previa con valores predeterminados para 'placeholder', 'text' y 'submit'.
        SearchBarSubmitView(placeholder: "Search", text: .constant("Search"), submit: .constant(true))
    }
}

