import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var dragGesture: some Gesture {
        DragGesture().onChanged { value in
            self.viewModel.movePlayer(value.location)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("Score: \(viewModel.score)")
                ForEach(viewModel.obstacles) { obstacle in
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
            .onAppear {
                viewModel.player = Player(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 2 * 20), width: 100, height: 20)
                viewModel.createDisplayLink()
            }
        }
        .alert(isPresented: $viewModel.isAlertPresented) {
            Alert(
                title: Text("Game Over"),
                message: Text("Would you like to play again? Your score is \(viewModel.score)"),
                primaryButton: .default(Text("Restart")) {
                    viewModel.restartGame()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel())
    }
}
