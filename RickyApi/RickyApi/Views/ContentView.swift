//
//  ContentView.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var rickyMortinStore: RickyMortinStore
    @State var alertVisible = false
    @State private var userInput: String = ""
    var body: some View {
        VStack {
            TextField("Buscar personaje", text: $userInput)
                .font(.body)
                .padding(8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(Color.gray)
            List {
                ForEach(rickyMortinStore.rickyMortinsData) { r in
                    if(r.name.lowercased().contains(userInput.lowercased()) || userInput == "") {
                        RowView(rickyMortin: r)
                    }
                }
            }.alert(isPresented: $alertVisible) {
                Alert(
                    title: Text("Error"),
                    message: Text(rickyMortinStore.error?.description ?? "Error"),
                    dismissButton: .default(Text("Reload data")){
                        rickyMortinStore.loadData()
                    }
                )
            }.onReceive(rickyMortinStore.$error) { error in
                if let _ = error {
                    self.alertVisible = true
                }
            }
        }.padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RickyMortinStore())
    }
}
