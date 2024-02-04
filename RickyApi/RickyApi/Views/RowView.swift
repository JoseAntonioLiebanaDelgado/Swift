//
//  RowView.swift
//  RickyApi
//
//  Created by alumne on 24/01/2024.
//

import SwiftUI
import KingfisherSwiftUI

struct RowView: View {
    let rickyMortin: RickyMortin
    var body: some View {
        VStack {
            HStack {
                Text("\(rickyMortin.id)")
                Spacer()
                Text(rickyMortin.name)
                Spacer()
                Text(rickyMortin.species)
            }
            if let url = rickyMortin.imageUrl {
                KFImage(url)
                    .resizable()
                    .frame(width: 175, height: 200)
            } else {
                Circle()
                    .foregroundColor(Color.orange)
                    .frame(width: 175, height: 200)
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(rickyMortin: RickyMortin.defaultValue)
    }
}
