import SwiftUI // Importa el framework SwiftUI para construir la interfaz de usuario.

// Define una estructura SearchBarView que implementa el protocolo View, lo que la convierte en una parte de la interfaz de usuario en SwiftUI.
struct SearchBarView: View {
    // placeholder es una variable para almacenar el texto que se mostrará cuando el campo de texto esté vacío.
    var placeholder: String
    // @Binding permite una conexión bidireccional con una propiedad de texto externa, lo que significa que las actualizaciones aquí se reflejarán fuera y viceversa.
    @Binding var text: String
    
    // Define el cuerpo de la vista, que SwiftUI usa para construir la interfaz de usuario.
    var body: some View {
        // HStack organiza los elementos de la barra de búsqueda horizontalmente.
        HStack {
            // Muestra un ícono de lupa al principio de la barra de búsqueda.
            Image(systemName: "magnifyingglass")
                .imageScale(.medium) // Configura el tamaño del ícono.
                .foregroundColor(Color(.systemGray3)) // Establece el color del ícono.
            
            // Crea un campo de texto para la entrada del usuario, enlazado a la variable de texto.
            TextField(placeholder, text: $text)
            
            // Muestra un botón de cancelar ('x') cuando hay texto en el campo de texto.
            if !text.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium) // Configura el tamaño del ícono de cancelar.
                    .foregroundColor(Color(.systemGray3)) // Establece el color del ícono de cancelar.
                    
                    // Añade un gesto de toque que vacía el campo de texto cuando se toca el ícono de cancelar.
                    .onTapGesture {
                        withAnimation {
                            self.text = "" // Limpia el campo de texto.
                        }
                    }
            }
        }
        .padding(8) // Añade un relleno alrededor de los elementos dentro de HStack.
        // Añade un borde redondeado alrededor de la barra de búsqueda.
        .overlay(RoundedRectangle(cornerRadius: 25.0).stroke())
        .foregroundColor(Color.gray) // Establece el color del borde de la barra de búsqueda.
    }
}

// Proporciona una vista previa de SearchBarView para facilitar la visualización y el diseño en el diseñador de Xcode.
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra la vista previa de SearchBarView con un valor predeterminado para 'placeholder' y 'text'.
        SearchBarView(placeholder: "Search", text: .constant("Search text"))
    }
}
