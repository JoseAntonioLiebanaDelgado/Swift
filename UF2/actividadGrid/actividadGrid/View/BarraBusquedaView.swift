//
//  BarraBusquedaView.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importación del módulo SwiftUI necesario para utilizar sus componentes y funcionalidades.
import SwiftUI

// Definición de `BarraBusquedaView` como una estructura que conforma al protocolo `View`, lo que indica que es una vista en el contexto de SwiftUI.
struct BarraBusquedaView: View {
    // Definición de `placeholder`, una variable que almacena el texto de marcador de posición que se muestra en el campo de texto cuando está vacío.
    var placeholder: String
    
    // `@Binding var text`: declaración de una propiedad vinculada (`Binding`) para `text`, lo que permite a esta vista compartir y modificar este valor con quien lo posea.
    @Binding var text: String
    
    // `@Binding var submit`: otra propiedad vinculada para `submit`, utilizada para controlar el estado de envío del formulario o de la búsqueda.
    @Binding var submit: Bool
    
    // Definición de la propiedad `body`, que describe el contenido y diseño de la vista. `some View` indica que devuelve algún tipo que conforma al protocolo `View`.
    var body: some View {
        // `HStack` crea un arreglo horizontal de vistas.
        HStack {
            // `TextField` define un campo de texto con un marcador de posición, valor vinculado y una acción de confirmación que cambia el estado de `submit`.
            TextField(placeholder, text: $text, onCommit: { submit.toggle() })
                .font(.body) // Establece el estilo de fuente del texto dentro del campo de texto.
                .padding(8) // Añade relleno alrededor del contenido del campo de texto.
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Aplica un estilo con bordes redondeados al campo de texto.
                .overlay(
                    // Overlay permite añadir vistas sobre el campo de texto, en este caso, un ícono de lupa.
                    HStack {
                        Spacer() // Un `Spacer` empuja las vistas adyacentes a ocupar el espacio máximo disponible.
                        Image(systemName: "magnifyingglass") // Añade una imagen de sistema (icono de lupa) dentro del campo de texto.
                                .foregroundColor(.gray) // Establece el color del icono.
                                .padding(.trailing, 8) // Añade relleno a la derecha del icono.
                    }.padding(.trailing, 10) // Añade relleno a la derecha del `HStack` que contiene el icono.
                )
            // Condición que muestra un botón para borrar el texto si `text` no está vacío.
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill") // Botón con un icono de sistema que representa una "X", utilizado para borrar el texto.
                }
            }
        }
        .padding(10) // Añade relleno alrededor del `HStack` completo, afectando su tamaño y posición.
    }
}


/* Estructura para la vista previa de `BarraBusquedaView`.
struct BarraBusquedaView_Previews: PreviewProvider {
    // Propiedad estática `previews` que devuelve algún tipo que conforma al protocolo `View`.
    static var previews: some View {
        // Instancia de `BarraBusquedaView` con valores concretos para los parámetros requeridos.
        BarraBusquedaView(
            placeholder: "Buscar...", // Texto de marcador de posición para el campo de búsqueda.
            text: .constant(""), // Valor vinculado para el texto, inicializado como vacío para la vista previa.
            submit: .constant(false) // Valor vinculado para el estado de envío, inicializado como falso para la vista previa.
        )
    }
}*/

 
