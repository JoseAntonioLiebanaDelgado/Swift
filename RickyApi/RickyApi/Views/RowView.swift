//
//  RowView.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import SwiftUI
import KingfisherSwiftUI // Importa KingfisherSwiftUI para la carga y visualización de imágenes desde URLs.

// Define una estructura RowView que conforma al protocolo View de SwiftUI, usada para representar una fila de datos.
struct RowView: View {
    // Declara una constante rickyMortin de tipo RickyMortin para almacenar la información del personaje.
    let rickyMortin: RickyMortin
    
    // Define el cuerpo de la vista, que describe la interfaz de usuario de la fila.
    var body: some View {
        // Usa VStack para organizar los elementos verticalmente.
        VStack {
            // Utiliza HStack para organizar los elementos horizontalmente dentro de la fila.
            HStack {
                Text("\(rickyMortin.id)") // Muestra el ID del personaje.
                Spacer() // Inserta un espacio flexible entre los elementos.
                Text(rickyMortin.name) // Muestra el nombre del personaje.
                Spacer() // Inserta otro espacio flexible.
                Text(rickyMortin.species) // Muestra la especie del personaje.
            }
            // Verifica si la URL de la imagen existe.
            if let url = rickyMortin.imageUrl {
                KFImage(url) // Usa KFImage de KingfisherSwiftUI para cargar la imagen desde la URL.
                    .resizable() // Hace la imagen redimensionable.
                    .frame(width: 175, height: 200) // Establece el tamaño de la imagen.
            } else {
                // Si no hay URL, muestra un marcador de posición circular de color naranja.
                Circle()
                    .foregroundColor(Color.orange)
                    .frame(width: 175, height: 200)
            }
        }
    }
}

// Proporciona una vista previa de RowView para el diseñador de interfaces de Xcode.
struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        // Crea una vista previa de RowView con un valor predeterminado de RickyMortin.
        RowView(rickyMortin: RickyMortin.defaultValue)
    }
}

