//
//  HistorialRondasView.swift
//  EnigmaShape
//
//  Created by alumne on 20/03/2024.
//

import SwiftUI

struct HistorialRondasView: View {

    @EnvironmentObject var gameStore: GameStore
    let columns = [ GridItem(.adaptive(minimum: 120)) ]
    
    var body: some View {
        NavigationView {
            if (hayRondasCompletadas()) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(obtenerRondasOrdenadas()) { ronda in
                            if (ronda.rondaFinalizada) {
                                CellView(ronda: ronda)
                            }
                        }
                    }
                    .padding(15)
                    .navigationBarTitle(Text("Historial de Rondas"), displayMode: .inline)
                }
            } else {
                VStack {
                    Text("Juega una ronda para ver tu historial de rondas")
                        .navigationBarTitle(Text("Historial de Rondas"), displayMode: .inline)
                        .padding(15)
                        .padding(.top)
                    Spacer()
                }
            }
        }
    }
    func hayRondasCompletadas() -> Bool {
        return gameStore.rondas.contains { $0.rondaFinalizada == true }
    }
    func obtenerRondasOrdenadas() -> [Ronda] {
        return gameStore.rondas.sorted { $0.numeroRonda < $1.numeroRonda }
    }
}

struct HistorialRondasView_Previews: PreviewProvider {
    static var previews: some View {
        HistorialRondasView()
    }
}
