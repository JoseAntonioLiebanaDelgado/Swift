//
//  ContentView.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import SwiftUI
import KingfisherSwiftUI  // Importa SwiftUI y Kingfisher para la gestión de imágenes.

struct ContentView: View {
    
    // @EnvironmentObject permite acceder a un objeto compartido en la jerarquía de vistas.
    @EnvironmentObject private var flickrPhotoStore: FlickrPhotoStore
    // @State se usa para crear propiedades de estado que pueden cambiar y hacer que la vista se actualice.
    @State var alertVisible = false  // Controla la visibilidad de una alerta.
    @State private var searchText = ""  // Almacena el texto de búsqueda ingresado por el usuario.
    @State private var isSearching = false  // Indica si se está realizando una búsqueda.
    
    // Define cómo se organizan las celdas en la cuadrícula, en este caso de forma adaptativa con un mínimo de 120 puntos de ancho.
    let columns = [ GridItem(.adaptive(minimum: 120)) ]
    
    var body: some View {
        // La vista principal es una VStack que organiza las subvistas verticalmente.
        VStack {
            // BarraBusquedaView es una vista personalizada para la barra de búsqueda.
            BarraBusquedaView(placeholder: "Escribe algo...", text: $searchText, submit: $isSearching)
            .onChange(of: isSearching, perform: { _ in  // Reacciona a los cambios en isSearching.
                updateSearchResults()  // Actualiza los resultados de búsqueda cuando cambia isSearching.
            })
            ScrollView {  // Permite desplazarse por el contenido si excede el tamaño de la pantalla.
                LazyVGrid(columns: columns, spacing: 20) {  // Organiza las celdas en una cuadrícula perezosa.
                    ForEach(flickrPhotoStore.fotosFlickr, id:\.id) { item in  // Itera sobre las fotos de Flickr.
                        Cell(item: item)  // Cell es una vista personalizada para mostrar cada foto.
                    }
                }.padding()  // Agrega un relleno alrededor de la cuadrícula.
            }
            .alert(isPresented: $alertVisible) {  // Muestra una alerta si alertVisible es verdadero.
                Alert(
                    title: Text("Error"),
                    message: Text(flickrPhotoStore.error?.description ?? "Error"),
                    dismissButton: .default(Text("Reload data")){  // Botón para recargar los datos.
                        flickrPhotoStore.loadData(searchInputUser: "nature")  // Carga datos predeterminados de "nature".
                    }
                )
            }.onReceive(flickrPhotoStore.$error) { error in  // Escucha los cambios en el error del FlickrPhotoStore.
                if let _ = error {
                    self.alertVisible = true  // Hace visible la alerta si hay un error.
                }
            }.onAppear{  // Cuando la vista aparece, carga datos de "nature".
                flickrPhotoStore.loadData(searchInputUser: "nature")
            }
        }.padding(10)  // Agrega un relleno alrededor de la VStack principal.
    }
    func updateSearchResults() {
        if (searchText.isEmpty) {
            flickrPhotoStore.loadData(searchInputUser: "nature")  // Carga "nature" si la búsqueda está vacía.
        } else {
            flickrPhotoStore.loadData(searchInputUser: searchText)  // Carga resultados basados en el texto de búsqueda.
        }
    }
}


/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Crear una instancia de FlickrPhotoStore.
        let store = FlickrPhotoStore()

        // Devolver ContentView envuelto en un EnvironmentObject.
        ContentView()
            .environmentObject(store) // Provee la instancia de store como un EnvironmentObject.
    }
}
