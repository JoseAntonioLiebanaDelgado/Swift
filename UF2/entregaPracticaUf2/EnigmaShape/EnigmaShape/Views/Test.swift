//
//  Test.swift
//  EnigmaShape
//
//  Created by alumne on 20/03/2024.
//

import SwiftUI

struct Test: View {
    @EnvironmentObject var gameStore: GameStore
    @State private var rotationAngle: Double = 0
    var body: some View {
        VStack{
            Text("Angle: \(rotationAngle)")
        Image(systemName: "star")
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(rotationAngle))
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            self.rotationAngle = angle.degrees
                        }
                )
            
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
