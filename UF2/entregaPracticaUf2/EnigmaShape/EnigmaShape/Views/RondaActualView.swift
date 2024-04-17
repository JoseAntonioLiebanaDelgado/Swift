//
//  RondaActualView.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

struct RondaActualView: View {
    var rondaActual: Ronda
    
    @Binding var widthActual: CGFloat
    @Binding var heightActual: CGFloat
    @State private var rotationAngle: Double = Double.random(in: 0...360)
    @Binding var desabilitarSliderGame: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Anchura")
                    Text("\(rondaActual.figuraRonda.tamanoFigura.width)")
                }
                Spacer()
                VStack {
                    Text("Altura")
                    Text("\(rondaActual.figuraRonda.tamanoFigura.height)")
                }
            }
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "\(rondaActual.figuraRonda.nombreFigura)")
                    .resizable()
                    .frame(width: widthActual, height: heightActual)
                    .foregroundColor(Color(hex: rondaActual.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())"))
                    .rotationEffect(.degrees(rotationAngle))
                        .gesture(
                            RotationGesture()
                                .onChanged { angle in
                                    self.rotationAngle = angle.degrees
                                }
                        )
                Spacer()
                VStack {
                    Text("Altura: \(Int(heightActual))")
                    Spacer()
                    Slider(value: $heightActual, in: 50...150)
                        .rotationEffect(.degrees(-90))
                        .frame(width: 100)
                        .accentColor(Color(hex: rondaActual.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())"))
                        .opacity(desabilitarSliderGame ? 0.5 : 1)
                        .disabled(desabilitarSliderGame)
                    Spacer()
                }
            }
            Spacer()
            HStack {
                Text("Anchura: \(Int(widthActual))")
                Slider(value: $widthActual, in: 50...150)
                    .frame(width: 100)
                    .accentColor(Color(hex: rondaActual.figuraRonda.colorFigura ?? "#\(Color.accentColor.toHex())"))
                    .opacity(desabilitarSliderGame ? 0.5 : 1)
                    .disabled(desabilitarSliderGame)
            }
        }.padding(10)
    }
}

/*
struct RondaActualView_Previews: PreviewProvider {
    static var previews: some View {
        RondaActualView()
    }
}
*/
