//
//  ContentView.swift
//  gamedummy
//
//  Created by alumne on 10/04/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewStoreModel
    
    var dragGesture: some Gesture{
        DragGesture().onChanged(){ value in
            self.viewModel.center = value.location
        }
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Circle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                    .position(viewModel.center)
                    .gesture(dragGesture)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear(){
                viewModel.center.x = geometry.size.width/2
                viewModel.center.y = geometry.size.height - 20
                viewModel.createDisplayLink()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
