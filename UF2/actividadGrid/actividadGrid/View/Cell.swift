//
//  Cell.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

import SwiftUI
import KingfisherSwiftUI

struct Cell: View {
    var item: FlickrPhoto
    var body: some View {
        VStack {
            KFImage(item.imageURL!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                Image(systemName: "person.crop.circle.badge.checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.ispublic == 1 ? Color.green : Color.red)
                
                Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.isfriend == 1 ? Color.green : Color.red)
                
                Image(systemName: "person.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.isfamily == 1 ? Color.green : Color.red)
            }
        }
    }
}

/*
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell()
    }
}
*/
