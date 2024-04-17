//
//  BotonesView.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

struct BotonesView: View {
    
    @EnvironmentObject var gameStore: GameStore
    @Binding var haVerificado: Bool
    var rondaActual: Ronda
    @Binding var widthActual: CGFloat
    @Binding var heightActual: CGFloat
    @State private var contadorPartidas: Int = 1
    @State private var ocultarBoton: Double = 1
    @State private var opacityResetIcon = 1.0
    @Binding var desabilitarSliderGame: Bool
    
    var body: some View {
        HStack() {
            /* Reset game */
            Image(systemName: "arrow.counterclockwise.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(hex: rondaActual.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())"))
                .opacity(opacityResetIcon)
                .gesture(
                    LongPressGesture(minimumDuration: 2)
                        .onChanged { _ in
                            withAnimation {
                                opacityResetIcon = 0.5
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                opacityResetIcon = 1
                            }
                        }
                        .onEnded { _ in
                            desabilitarSliderGame = false
                            widthActual = 50
                            heightActual = 50
                            gameStore.resetGame()
                            opacityResetIcon = 1
                            contadorPartidas = 1
                            ocultarBoton = 1
                            haVerificado = false
                        }
                )
            
            /* Check ronda */
            Button(action: {
                if (gameStore.numPartida != 6) {
                    desabilitarSliderGame.toggle()
                }
                let alturaPuestaInt = Int(heightActual)
                let anchuraPuestaInt = Int(widthActual)
                let mostrarSonidoGanar = gameStore.checkRonda(
                    rondaActual: rondaActual,
                    alturaPuesta: alturaPuestaInt,
                    anchuraPuesta: anchuraPuestaInt
                )
                self.haVerificado.toggle()
                
                if (mostrarSonidoGanar) {
                    gameStore.playSound(name: "rondaganada")
                } else {
                    gameStore.playSound(name: "rondaperdida")
                }
            }) {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(
                        self.haVerificado ?
                            Color.gray :
                            Color(hex: rondaActual.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())")
                            
                    )
            }
            .disabled(self.haVerificado)
            
            /* Siguiente Ronda */
            Button(action: {
                desabilitarSliderGame.toggle()
                if (contadorPartidas < 6) {
                    contadorPartidas += 1
                    gameStore.pasarSiguienteRonda(rondaActual: rondaActual)
                    self.haVerificado.toggle()
                } else {
                    ocultarBoton = 0
                }
                widthActual = 50
                heightActual = 50
                gameStore.playSound(name: "siguienteronda")
            }) {
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(
                        self.haVerificado ?
                            Color(hex: rondaActual.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())") :
                            Color.gray
                    )
            }
            .disabled(!self.haVerificado)
            .opacity(ocultarBoton)
        }
    }
}

/*
struct BotonesView_Previews: PreviewProvider {
    static var previews: some View {
        BotonesView()
    }
}
*/
