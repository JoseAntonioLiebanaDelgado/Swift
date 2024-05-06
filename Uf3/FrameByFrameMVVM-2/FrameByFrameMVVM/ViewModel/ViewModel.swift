import SwiftUI

class ViewModel: ObservableObject {
    
    private var displaylink: CADisplayLink?
    
    @Published var player: Player?
    @Published var obstacles = [Obstacle]()
    @Published private(set) var score = 0
    private var step = 0
    @Published var showRestartAlert = false
    
    private var isGameOver = false
    

    func createDisplayLink() {
        displaylink = CADisplayLink(target: self,
                                        selector: #selector(gameLoop))
        
        displaylink?.add(to: .current,
                         forMode: RunLoop.Mode.default)
    }
    
    @objc private func gameLoop(displaylink: CADisplayLink) {
        
        //create an obstacle every XXs and max obstacles
        if step%(3*60)==0{
            let obstacle = Obstacle(center: CGPoint(x:CGFloat.random(in: 50..<UIScreen.main.bounds.maxX-50),y:20), width: 30, height: 30)
            obstacles.append(obstacle)
            
        }
        step+=1
        
        // Store indices of obstacles to remove
        var obstaclesToRemove = [Int]()
        
        // move obstacles
        for index in 0..<obstacles.count {
            objectWillChange.send()
            obstacles[index].move()
            
            if obstacles[index].checkScreenCollision() {
                // update score
                self.score += 1
                print("Updating score \(score)")
                obstaclesToRemove.append(index)
            } else if let p = player, obstacles[index].checkCollisionWith(p.frame) {
                isGameOver = true
                break
            }
        }
        
        // Remove obstacles marked for removal
        for index in obstaclesToRemove.reversed() {
            obstacles.remove(at: index)
        }
        
        if isGameOver {
            doGameOver()
        }
        // detect game over
    }
    
    func doGameOver() {
        print("gameOver")
        displaylink?.remove(from: .current,
                            forMode: RunLoop.Mode.default)
        obstacles.removeAll()
        player?.center
        showRestartAlert = true
        // TODO: Situar al player en su posición de inicio (centrado horizontalmente y en límite inferior de la pantalla)
        // TODO: Mostrar alerta para permitir reiniciar el juego al usuario
    }
    
    func restartGame(geometry: GeometryProxy) {
        showRestartAlert = false
        score = 0
        isGameOver = false
        createDisplayLink()
        
        // Situar al jugador en la posición inicial
        if let player = player {
            player.center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 2 * 20)
        }
    }

    
    // Intent View
    func movePlayer(_ point:CGPoint) {
        objectWillChange.send()
        self.player?.moveToPoint(point)
    }
    
}
