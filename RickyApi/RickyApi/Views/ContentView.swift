//
//  ContentView.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import SwiftUI

// Define una estructura ContentView que confirma al protocolo View, lo que la hace una parte de la interfaz de usuario en SwiftUI.
struct ContentView: View {
    // Utiliza el EnvironmentObject para inyectar una instancia de RickyMortinStore que se comparte en todo el entorno de la app.
    @EnvironmentObject private var rickyMortinStore: RickyMortinStore
    
    // Define una variable de estado que controla la visibilidad de una alerta en la interfaz de usuario.
    @State var alertVisible = false
    
    // Define una variable de estado para capturar y enlazar el texto de entrada del usuario en el campo de texto.
    @State private var userInput: String = ""
    
    // Define el cuerpo de ContentView, describiendo la interfaz de usuario.
    var body: some View {
        // Usa un VStack para organizar los elementos de la vista verticalmente.
        VStack {
            // Crea un campo de texto que permite a los usuarios introducir texto.
            TextField("Buscar personaje", text: $userInput)
                .font(.body) // Establece la fuente del texto.
                .padding(8) // Añade un relleno alrededor del campo de texto.
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Aplica un estilo con bordes redondeados.
                .border(Color.gray) // Añade un borde de color gris alrededor del campo de texto.
            
            // Crea una lista que muestra los datos de los personajes.
            List {
                // Itera sobre los datos de personajes en rickyMortinStore.
                ForEach(rickyMortinStore.rickyMortinsData) { r in
                    // Filtra los personajes que coinciden con la entrada del usuario.
                    if(r.name.lowercased().contains(userInput.lowercased()) || userInput == "") {
                        RowView(rickyMortin: r) // Crea una vista de fila para cada personaje.
                    }
                }
            // Presenta una alerta si alertVisible es verdadero.
            }.alert(isPresented: $alertVisible) {
                // Define el contenido y comportamiento de la alerta.
                Alert(
                    title: Text("Error"), // Establece el título de la alerta.
                    message: Text(rickyMortinStore.error?.description ?? "Error"), // Establece el mensaje de la alerta.
                    dismissButton: .default(Text("Reload data")){ // Agrega un botón para reintentar la carga de datos.
                        rickyMortinStore.loadData() // Carga los datos nuevamente cuando se presiona el botón.
                    }
                )
            // Añade un modificador para recibir notificaciones cuando el error cambia.
            }.onReceive(rickyMortinStore.$error) { error in
                // Verifica si hay un error y activa la alerta.
                if let _ = error {
                    self.alertVisible = true
                }
            }
        // Añade un relleno alrededor de la vista completa.
        }.padding(10)
    }
}

// Proporciona una vista previa de ContentView para el diseñador de interfaces de Xcode.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Crea una instancia de ContentView y le inyecta una instancia de RickyMortinStore.
        ContentView().environmentObject(RickyMortinStore())
    }
}
