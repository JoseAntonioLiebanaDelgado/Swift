//
//  ItemDetailView.swift
//  actividadGrid
//
//  Created by alumne on 06/03/2024.
//

import SwiftUI
import KingfisherSwiftUI

struct ItemDetailView: View {
    var item: FlickrPhoto
    @State var isLikedPhoto: Bool = false
    @State var scale: CGFloat = 1
    @State var hideIconsInfoPhoto: Bool = false
    
    var magnificationGesture: some Gesture {
       return MagnificationGesture()
        .onChanged { value in
            self.scale = value.magnitude
            self.hideIconsInfoPhoto = true
        }
        .onEnded { _ in
            self.scale = 1
            self.hideIconsInfoPhoto = false
        }
    }
    
    var body: some View {
        VStack {
            KFImage(item.imageURL!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture(count: 2) {
                    self.isLikedPhoto.toggle()
                }
                .scaleEffect(scale)
                .gesture(magnificationGesture)
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(self.isLikedPhoto ? Color.green : Color.gray)
                                .padding(20)
                        }
                        Spacer()
                    }
                )
            HStack {
                Image(systemName: "lock.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.ispublic == 1 ? Color.green : Color.red)
                .opacity(hideIconsInfoPhoto ? 0 : 1)
                
                Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.isfriend == 1 ? Color.green : Color.red)
                .opacity(hideIconsInfoPhoto ? 0 : 1)
                
                Image(systemName: "person.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.isfamily == 1 ? Color.green : Color.red)
                .opacity(hideIconsInfoPhoto ? 0 : 1)
            }
        }
    }
}

/*
struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
 */
