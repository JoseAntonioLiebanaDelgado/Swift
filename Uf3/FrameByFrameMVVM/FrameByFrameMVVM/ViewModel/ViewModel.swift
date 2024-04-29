import SwiftUI

class ViewModel:ObservableObject{
    
    private var displaylink:CADisplayLink?
    private var step = 0
    private let stepSeconds = 1
    @Published var gameOver: Bool = false
    
    @Published var player:Player?
    @Published var obstacles = [Obstacle]()
    @Published private(set) var score = 0
    @Published var inicialCenter = CGPoint(x: 0, y: 0)
    
    
    /*init() {
        self.player = Player(center: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY - 100), width: 50, height: 50)
    }*/

    func createDisplayLink() {
        displaylink = CADisplayLink(target: self,
                                        selector: #selector(gameLoop))
        
        displaylink?.add(to: .current,
                         forMode: RunLoop.Mode.default)
    }
    
    @objc private func gameLoop(displaylink: CADisplayLink) {
        
        //create an obstacle every XXs
        if (step%(self.stepSeconds*60) == 0 && obstacles.count <= 10) {
            let newObstacle = Obstacle(center: CGPoint(x: CGFloat.random(in: 50 ..< UIScreen.main.bounds.maxX - 50), y: 20), width: 30, height: 30)
            obstacles.append(newObstacle)
        }
        step+=1
        
        //move obstacles
        for index in 0 ..< obstacles.count {
            objectWillChange.send()
            obstacles[index].move()
            
            if obstacles[index].checkScreenCollision() {
                //update score
                self.score+=1
                //obstacles[index].restart()
                obstacles.remove(at: index)
            } else if let p = self.player,obstacles[index].checkCollisionWith(p.frame) {
                self.gameOver = true
                break
            }
        }
        
        //detect game over
        if self.gameOver {
            doGameOver()
        }
    }
    
    func doGameOver() {
        print("Game Over - \(inicialCenter)")
        displaylink?.remove(from: .current,
                            forMode: RunLoop.Mode.default)
        self.obstacles.removeAll()
        movePlayer(inicialCenter)
    }
    
    func restartGame() {
        self.gameOver = false
        self.score = 0
        self.step = 0
    }
    
    // Intent View
    func movePlayer(_ point: CGPoint) {
        objectWillChange.send()
        self.player?.moveToPoint(point)
    }
}
