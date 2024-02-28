//
//  BarraBusquedaView.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import SwiftUI

struct BarraBusquedaView: View {
    var placeholder: String
    @Binding var text: String
    @Binding var submit: Bool
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text, onCommit: { submit.toggle() })
                .font(.body)
                .padding(8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                    }.padding(.trailing, 10)
                )
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .padding(10)
    }
}
/*
struct BarraBusquedaView_Previews: PreviewProvider {
    static var previews: some View {
       BarraBusquedaView(placeholder: String, text: <#T##Binding<String>#>, submit: <#T##Binding<Bool>#>)
    }
}
 */
