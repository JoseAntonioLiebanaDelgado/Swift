//
//  ContentView.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import SwiftUI
import KingfisherSwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var flickrPhotoStore: FlickrPhotoStore
    @State var alertVisible = false
    @State private var searchText = ""
    @State private var isSearching = false
    
    let columns = [ GridItem(.adaptive(minimum: 120)) ]
    
    var body: some View {
        NavigationView {
            VStack {
                BarraBusquedaView(placeholder: "Escribe algo...", text: $searchText, submit: $isSearching)
                .onChange(of: isSearching, perform: { _ in
                    updateSearchResults()
                })
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(flickrPhotoStore.fotosFlickr, id:\.id) { item in
                            NavigationLink(destination: ItemDetailView(item: item)) {
                                Cell(item: item)
                            }
                        }
                    }.padding()
                }
                .alert(isPresented: $alertVisible) {
                    Alert(
                        title: Text("Error"),
                        message: Text(flickrPhotoStore.error?.description ?? "Error"),
                        dismissButton: .default(Text("Reload data")){
                            flickrPhotoStore.loadData(searchInputUser: "nature")
                            self.alertVisible = false
                        }
                    )
                }.onReceive(flickrPhotoStore.$error) { error in
                    if let _ = error {
                        self.alertVisible = true
                    }
                }.onAppear{
                    flickrPhotoStore.loadData(searchInputUser: "nature")
                }
            }
            .padding(10)
            .navigationBarTitle("Buscador Flickr", displayMode: .inline)
        }
    }
    func updateSearchResults() {
        if (searchText.isEmpty) {
            flickrPhotoStore.loadData(searchInputUser: "nature")
        } else {
            flickrPhotoStore.loadData(searchInputUser: searchText)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
