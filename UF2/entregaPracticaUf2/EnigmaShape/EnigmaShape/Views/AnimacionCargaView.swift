//
//  AnimacionCargaView.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

struct AnimacionCargaView: View {
    @State private var opacityDefault: Double = 0.25
    @State private var opacityFinal: Double = 1
    @State private var empezarAnimacion: Bool = false
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .opacity(empezarAnimacion ? opacityFinal : opacityDefault)
    
            Text("¡Bienvenido a Enigma Shape👋!")
                .font(.title2)
                .opacity(empezarAnimacion ? opacityFinal : opacityDefault)
        }
        .animation(Animation.easeIn(duration: 2).repeatCount(1, autoreverses: false))
        .onAppear {
            self.empezarAnimacion = true
        }
    }
}


struct AnimacionCargaView_Previews: PreviewProvider {
    static var previews: some View {
        AnimacionCargaView()
    }
}
