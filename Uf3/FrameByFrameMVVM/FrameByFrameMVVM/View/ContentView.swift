import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:ViewModel
    @State private var showingAlert = false
    
    var dragGesture: some Gesture {
        DragGesture().onChanged() { value in
            self.viewModel.movePlayer(value.location)
        }
    }
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
            GeometryReader { geometry in
                ZStack {
                    ForEach (viewModel.obstacles) { obstacle in
                        Circle()
                            .fill(Color.red)
                            .frame(width: obstacle.width, height: obstacle.height)
                            .position(obstacle.center)
                    }
                    
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: viewModel.player?.width, height: viewModel.player?.height)
                        .position(viewModel.player?.center ?? CGPoint.zero)
                        .gesture(dragGesture)
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                .ignoresSafeArea()
                .background(Color.gray)
                .onAppear {
                    viewModel.player = Player(center: CGPoint(x: geometry.size.width/2, y: geometry.size.height - 2*20), width: 100, height: 20)
                    viewModel.createDisplayLink()
                    viewModel.inicialCenter = CGPoint(x: geometry.size.width/2, y: geometry.size.height - 2*20)
                }
                .onChange(of: viewModel.gameOver) { _ in
                    if viewModel.gameOver == true {
                        showingAlert = true
                    }
                    
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("GameOver"),
                        message: Text("Your score is: \(viewModel.score)!"),
                        dismissButton: .default(Text("Reload match")) {
                            print("Game over = \(viewModel.gameOver)")
                            viewModel.restartGame()
                            viewModel.createDisplayLink()
                            showingAlert = false
                            print("Game over = \(viewModel.gameOver)")
                        }
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
