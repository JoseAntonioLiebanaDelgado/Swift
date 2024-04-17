//
//  CellView.swift
//  EnigmaShape
//
//  Created by alumne on 21/03/2024.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var gameStore: GameStore
    @State private var isHeartScaled = false
    var ronda: Ronda
    
    var body: some View {
        VStack {
            HStack {
                Text("Ronda \(ronda.numeroRonda)")
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(ronda.leHaGustadoLaPartida ? Color.red : Color.gray)
            }
            Image(systemName: "\(ronda.figuraRonda.nombreFigura)")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(Color(hex: ronda.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())"))
                .overlay(
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: isHeartScaled ? 65 : 0, height: 60)
                        .foregroundColor(.red)
                        .opacity(isHeartScaled ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 0.75).repeatCount(1,autoreverses: true))
                )
                .onTapGesture(count: 2) {
                    let estado = ronda.leHaGustadoLaPartida
                    gameStore.actualizarEstadoCorazonRonda(
                        ronda: ronda,
                        estado: !estado
                    )
                    self.isHeartScaled.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        // Despues de cargar la animacion, para poder ocultar el corazón, hacemos que se cambie
                        // el estado de nuevo
                        self.isHeartScaled.toggle()
                    }
                }
            Text("Puntuación: \(ronda.puntuacionRonda)")
        }
        .padding(10)
        .border(Color.gray, width: 1)
        .cornerRadius(20)
    }
}

/*
struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView()
    }
}
 */
