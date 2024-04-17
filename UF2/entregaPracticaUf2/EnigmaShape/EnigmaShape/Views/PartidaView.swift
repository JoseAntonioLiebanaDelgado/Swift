//
//  PartidaView.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

struct PartidaView: View {
    @EnvironmentObject var gameStore: GameStore
    
    @State var haVerificadoLaRonda: Bool = false
    @State var widthActual: CGFloat = 50
    @State var heightActual: CGFloat = 50
    @State var desabilitarSliderGame: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    VStack {
                        Text("Puntuación Total")
                        Text("\(gameStore.puntuacionTotal)")
                    }
                    Spacer()
                    VStack {
                        Text("Número ronda")
                        Text("\(gameStore.numPartida)")
                    }
                }
                Spacer()
                RondaActualView(
                    rondaActual: gameStore.rondaActual!,
                    widthActual: $widthActual,
                    heightActual: $heightActual,
                    desabilitarSliderGame: $desabilitarSliderGame
                )
                .border(Color.gray, width: 1)
                .cornerRadius(20)
                Spacer()
                BotonesView(
                    haVerificado: $haVerificadoLaRonda,
                    rondaActual: gameStore.rondaActual!,
                    widthActual: $widthActual,
                    heightActual: $heightActual,
                    desabilitarSliderGame: $desabilitarSliderGame
                )
            }
            .navigationBarTitle(Text("Enigma Shape"), displayMode: .inline)
            .padding(15)
        }
    }
}

/* Esta extension nos permite poder usar hexadecimales para los colores */
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components else { return "" }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}

struct PartidaView_Previews: PreviewProvider {
    static var previews: some View {
        PartidaView()
    }
}
