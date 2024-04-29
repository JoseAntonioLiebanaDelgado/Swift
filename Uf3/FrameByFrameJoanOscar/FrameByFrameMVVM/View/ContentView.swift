import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:ViewModel
    
    var dragGesture: some Gesture{
        DragGesture().onChanged(){value in
            self.viewModel.movePlayer(value.location)
        }
    }
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                Text("Score: \(viewModel.score)")
                ForEach(viewModel.obstacles){obstacle in
                    Circle()
                        .fill(Color.red)
                        .frame(width: obstacle.width, height: obstacle.height)
                        .position(obstacle.center)
            }
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: viewModel.player?.width, height: viewModel.player?.height)
                    .position(viewModel.player?.center ?? CGPoint.zero)
                    .gesture(dragGesture)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear(){
                viewModel.player = Player(center: CGPoint(x:geometry.size.width/2,y:geometry.size.height-2*20), width: 100, height: 20)
                viewModel.player?.initialCenter = CGPoint(x: geometry.size.width/2, y: geometry.size.height-2*20)
                viewModel.createDisplayLink()
            }
            .alert(isPresented: $viewModel.showAlert){
                Alert(title: Text("Has perdido"), message: Text("Dale al boton para reiniciar"),
                      dismissButton: .default(
                        Text("Reiniciar"),
                        action: {
                            viewModel.showAlert = false
                            viewModel.createDisplayLink()
                            viewModel.obstacles.removeAll()
                        }))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
