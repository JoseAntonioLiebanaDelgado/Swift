// Importa el framework SwiftUI para construir la interfaz de usuario.
import SwiftUI

// Define la estructura 'EmojiPicker' que conforma al protocolo 'View'.
struct EmojiPicker: View {
    // Usa '@Binding' para crear una conexión bidireccional con una propiedad que almacena el emoji de fruta seleccionado.
    @Binding var emoji: EmojiFruit

    // Define el cuerpo de la vista 'EmojiPicker'.
    var body: some View {
        // Crea un 'Picker' con un enlace a la propiedad 'emoji' para controlar la selección.
        Picker(selection: $emoji, label: Text("")) {
            // Itera sobre todos los casos de 'EmojiFruit' para crear una fila en el Picker por cada emoji.
            ForEach(EmojiFruit.allCases, id: \.self) { emojiCase in
                // Muestra el emoji (valor raw del enum) con un estilo de fuente grande.
                Text(emojiCase.rawValue).font(.largeTitle)
            }
        }
        // Aplica el estilo 'WheelPickerStyle' al 'Picker' para darle una apariencia de ruleta.
        .pickerStyle(WheelPickerStyle())
    }
}

// Define una vista previa para 'EmojiPicker'.
struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra 'EmojiPicker' en el modo de vista previa con un valor inicial de 'apple'.
        EmojiPicker(emoji: .constant(EmojiFruit.apple))
    }
}
