import SwiftUI

// ViewModel que controla la lógica y el estado del juego.
class ViewModel: ObservableObject {
    
    // Variable para manejar el CADisplayLink, que ayuda a sincronizar la actualización del juego con la pantalla.
    private var displaylink: CADisplayLink?
    
    // Publica cambios en el jugador, obstáculos, puntuación y estado del reinicio del juego.
    @Published var player: Player?
    @Published var obstacles = [Obstacle]()
    @Published private(set) var score = 0
    private var step = 0
    @Published var showRestartAlert = false
    
    // Bandera para indicar si el juego ha terminado.
    private var isGameOver = false

    // Crea y configura el CADisplayLink para llamar a gameLoop a intervalos regulares.
    func createDisplayLink() {
        // Inicializa el CADisplayLink con el objetivo y el selector del método gameLoop.
        displaylink = CADisplayLink(target: self, selector: #selector(gameLoop))
        // Añade el CADisplayLink al run loop actual en el modo por defecto.
        displaylink?.add(to: .current, forMode: RunLoop.Mode.default)
    }
    
    // Función que se llama en cada frame para actualizar el estado del juego.
    @objc private func gameLoop(displaylink: CADisplayLink) {
        
        // Crea un obstáculo cada 3 segundos aproximadamente.
        if step % (3 * 60) == 0 {
            let obstacle = Obstacle(center: CGPoint(x: CGFloat.random(in: 50..<UIScreen.main.bounds.maxX - 50), y: 20), width: 30, height: 30)
            obstacles.append(obstacle)
        }
        step += 1
        
        // Lista para almacenar los índices de los obstáculos que se deben eliminar.
        var obstaclesToRemove = [Int]()
        
        // Mueve los obstáculos y verifica colisiones.
        for index in 0..<obstacles.count {
            objectWillChange.send()
            obstacles[index].move()
            
            // Si el obstáculo sale de la pantalla, se actualiza la puntuación y se marca para eliminar.
            if obstacles[index].checkScreenCollision() {
                self.score += 1
                print("Updating score \(score)")
                obstaclesToRemove.append(index)
            } else if let p = player, obstacles[index].checkCollisionWith(p.frame) {
                // Si el obstáculo colisiona con el jugador, el juego termina.
                isGameOver = true
                break
            }
        }
        
        // Elimina los obstáculos que se han marcado para eliminar.
        for index in obstaclesToRemove.reversed() {
            obstacles.remove(at: index)
        }
        
        // Si el juego ha terminado, llama a la función para manejar el fin del juego.
        if isGameOver {
            doGameOver()
        }
    }
    
    // Maneja las acciones que deben realizarse cuando el juego termina.
    func doGameOver() {
        print("gameOver")
        // Detiene el CADisplayLink.
        displaylink?.remove(from: .current, forMode: RunLoop.Mode.default)
        // Elimina todos los obstáculos.
        obstacles.removeAll()
        // Muestra una alerta para reiniciar el juego.
        showRestartAlert = true
        // TODO: Situar al jugador en su posición de inicio (centrado horizontalmente y en límite inferior de la pantalla).
        // TODO: Mostrar alerta para permitir reiniciar el juego al usuario.
    }
    
    // Reinicia el juego y coloca al jugador en la posición inicial.
    func restartGame(geometry: GeometryProxy) {
        showRestartAlert = false
        score = 0
        isGameOver = false
        // Vuelve a crear el CADisplayLink.
        createDisplayLink()
        
        // Situar al jugador en la posición inicial.
        if let player = player {
            player.center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 2 * 20)
        }
    }

    // Mueve al jugador a un nuevo punto.
    func movePlayer(_ point: CGPoint) {
        objectWillChange.send()
        self.player?.moveToPoint(point)
    }
}
