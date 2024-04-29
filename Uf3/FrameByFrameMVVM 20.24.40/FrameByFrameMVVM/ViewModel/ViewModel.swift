import SwiftUI

class ViewModel:ObservableObject{
    
    private var displaylink:CADisplayLink?
    
    @Published  var player:Player?
    @Published var obstacles = [Obstacle]()
    @Published private(set) var score = 0
    @Published var isAlertPresented = false
    private var step = 0
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
        //move obstacles
        for index in 0..<obstacles.count{
            objectWillChange.send()
            obstacles[index].move()
            if obstacles[index].checkScreenCollision(){
                //update score
                self.score+=1
                print("Updating score \(score)")
                obstacles.remove(at: index)
            }else if let p = player, obstacles[index].checkCollisionWith(p.frame){
                isGameOver = true
                break
            }
                
            }
        if isGameOver{
            doGameOver()
        }
        //detect game over
    }
    
    // ViewModel.
    func doGameOver() {
        print("gameOver")
        displaylink?.invalidate()
        displaylink = nil
        obstacles.removeAll()
        isAlertPresented = true
        
        // No necesitas 'if let' aquí, ya que 'UIScreen.main.bounds.size' no es opcional.
        let windowSize = UIScreen.main.bounds.size
        
        // Asegúrate de que 'player' existe antes de intentar cambiar su propiedad 'center'.
        if let playerHeight = player?.height {
            player?.center = CGPoint(x: windowSize.width / 2, y: windowSize.height - playerHeight / 2)
        }
    }


    
    //Intent View
    func movePlayer(_ point:CGPoint){
        objectWillChange.send()
        self.player?.moveToPoint(point)
    }
    
    
    func restartGame() {
        // Restablece la puntuación a 0
        score = 0
        obstacles.removeAll()
        isGameOver = false
        isAlertPresented = false
        let windowSize = UIScreen.main.bounds.size
        player?.center = CGPoint(x: windowSize.width / 2, y: windowSize.height - player!.height / 2)
        createDisplayLink()
    }

}
