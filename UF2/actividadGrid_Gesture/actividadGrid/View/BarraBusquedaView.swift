//
//  BarraBusquedaView.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework SwiftUI, necesario para usar sus componentes y funcionalidades.
import SwiftUI

// Define una estructura llamada BarraBusquedaView que conforma al protocolo View, permitiéndole ser una parte de la interfaz de usuario.
struct BarraBusquedaView: View {
    // 'placeholder' es una variable que almacenará el texto que se muestra cuando el campo de texto está vacío.
    var placeholder: String
    // '@Binding var text': Declara una variable vinculada que permitirá a esta vista compartir y modificar el estado de una variable de otra vista.
    @Binding var text: String
    // '@Binding var submit': Declara otra variable vinculada para controlar un estado de envío (submit), que puede ser utilizado para realizar acciones cuando el usuario envía el texto.
    @Binding var submit: Bool
    
    // La propiedad computada 'body' define el contenido de la vista y su layout.
    var body: some View {
        // HStack organiza sus vistas hijo horizontalmente.
        HStack {
            // Crea un campo de texto con un 'placeholder', vinculado a la variable 'text'. 'onCommit' se llama cuando el usuario envía el texto (por ejemplo, al presionar Return en el teclado).
            TextField(placeholder, text: $text, onCommit: { submit.toggle() })
                // Establece la fuente del texto dentro del campo de texto.
                .font(.body)
                // Aplica un padding alrededor del contenido del campo de texto.
                .padding(8)
                // Aplica un estilo de borde redondeado al campo de texto.
                .textFieldStyle(RoundedBorderTextFieldStyle())
                // Agrega una vista de superposición al campo de texto, que contiene una lupa al final del campo.
                .overlay(
                    HStack {
                        // Spacer empuja el contenido hacia la izquierda, dejando la lupa al final.
                        Spacer()
                        // Crea una imagen de una lupa y la coloca en la superposición.
                        Image(systemName: "magnifyingglass")
                                // Establece el color de la imagen a gris.
                                .foregroundColor(.gray)
                                // Aplica un padding a la derecha de la imagen de la lupa.
                                .padding(.trailing, 8)
                    // Aplica un padding adicional a la derecha de la superposición completa para asegurar un espacio adecuado.
                    }.padding(.trailing, 10)
                )
            // Si el texto no está vacío, muestra un botón con una 'x' que, al ser presionado, limpia el texto.
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        // Aplica un padding alrededor del HStack completo.
        .padding(10)
    }
}

/*
struct BarraBusquedaView_Previews: PreviewProvider {
    static var previews: some View {
       BarraBusquedaView(placeholder: String, text: <#T##Binding<String>#>, submit: <#T##Binding<Bool>#>)
    }
}
 */

