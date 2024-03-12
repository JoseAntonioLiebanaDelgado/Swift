//
//  ContentView.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa los frameworks necesarios: SwiftUI para la interfaz de usuario y KingfisherSwiftUI para la carga de imágenes.
import SwiftUI
import KingfisherSwiftUI

// Define la estructura ContentView que conforma al protocolo View.
struct ContentView: View {
    // Usa EnvironmentObject para acceder a una instancia compartida de FlickrPhotoStore, que administra la carga de fotos de Flickr.
    @EnvironmentObject private var flickrPhotoStore: FlickrPhotoStore
    // State variables para manejar la visibilidad de la alerta, el texto de búsqueda y el estado de búsqueda.
    @State var alertVisible = false
    @State private var searchText = ""
    @State private var isSearching = false
    
    // Define la configuración de la cuadrícula para las fotos, con celdas de tamaño adaptativo.
    let columns = [ GridItem(.adaptive(minimum: 120)) ]
    
    // La propiedad computada 'body' define el contenido de la vista y su layout.
    var body: some View {
        NavigationView {
            VStack {
                // Agrega la barra de búsqueda personalizada, pasando los estados necesarios como bindings.
                BarraBusquedaView(placeholder: "Escribe algo...", text: $searchText, submit: $isSearching)
                .onChange(of: isSearching, perform: { _ in
                    updateSearchResults()
                })
                // ScrollView permite desplazarse por el contenido de la vista.
                ScrollView {
                    // LazyVGrid organiza las fotos en una cuadrícula, cargándolas de manera perezosa.
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(flickrPhotoStore.fotosFlickr, id:\.id) { item in
                            // Cada foto es un NavigationLink que conduce a una vista detallada de la foto.
                            NavigationLink(destination: ItemDetailView(item: item)) {
                                Cell(item: item)
                            }
                        }
                    }.padding()
                }
                // Muestra una alerta en caso de un error al cargar los datos.
                .alert(isPresented: $alertVisible) {
                    Alert(
                        title: Text("Error"),
                        message: Text(flickrPhotoStore.error?.description ?? "Error"),
                        dismissButton: .default(Text("Reload data")){
                            // Intenta recargar los datos si se pulsa el botón de la alerta.
                            flickrPhotoStore.loadData(searchInputUser: "nature")
                            self.alertVisible = false
                        }
                    )
                // Observa el estado de error y muestra una alerta si ocurre uno.
                }.onReceive(flickrPhotoStore.$error) { error in
                    if let _ = error {
                        self.alertVisible = true
                    }
                // Carga los datos iniciales cuando aparece la vista.
                }.onAppear{
                    flickrPhotoStore.loadData(searchInputUser: "nature")
                }
            }
            // Configura el título de la barra de navegación y su estilo.
            .padding(10)
            .navigationBarTitle("Buscador Flickr", displayMode: .inline)
        }
    }
    // Función para actualizar los resultados de búsqueda basándose en el texto de búsqueda.
    func updateSearchResults() {
        if (searchText.isEmpty) {
            flickrPhotoStore.loadData(searchInputUser: "nature")
        } else {
            flickrPhotoStore.loadData(searchInputUser: searchText)
        }
    }
}

// Proporciona una vista previa de ContentView dentro del editor de Xcode.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
