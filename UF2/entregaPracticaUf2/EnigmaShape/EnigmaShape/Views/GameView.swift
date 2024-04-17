//
//  GameView.swift
//  EnigmaShape
//
//  Created by alumne on 18/03/2024.
//

import SwiftUI

struct GameView: View {
    @State private var pulsing = true
    var body: some View {
        VStack {
            if pulsing {
                AnimacionCargaView()
            } else {
                PartidaView()
            }
            if pulsing != false {
                Button(action: {
                    self.pulsing.toggle()
                }) {
                    Text("¡Comenzar!")
                        .font(.title)
                }
                .padding(15)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
