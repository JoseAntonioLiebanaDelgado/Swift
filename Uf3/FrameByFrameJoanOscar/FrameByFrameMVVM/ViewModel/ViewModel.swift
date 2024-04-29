import SwiftUI

class ViewModel:ObservableObject{
    
    private var displaylink:CADisplayLink?
    
    @Published  var player:Player?
    @Published var obstacles = [Obstacle]()
    @Published private(set) var score = 0
    private var step = 0
    private var isGameOver = false
    @Published var showAlert = false
    

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
                doGameOver()
            }
            
        }
        
        //detect game over
    }
    
    func doGameOver(){
        
        print("gameOver")
        displaylink?.remove(from: .current,
                         forMode: RunLoop.Mode.default)
        obstacles.removeAll()
        player?.moveToPoint(player?.initialCenter ?? CGPoint.zero)
        //TODO: Mostrar alerta para permitir reiniciar el juego al usuario
        showAlert = true
        objectWillChange.send()
        score = 0
        
    }
    
    //Intent View
    func movePlayer(_ point:CGPoint){
        objectWillChange.send()
        self.player?.moveToPoint(point)
    }
    
}
