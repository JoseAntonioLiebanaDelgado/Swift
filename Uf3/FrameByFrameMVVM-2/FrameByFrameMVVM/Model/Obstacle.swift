// Importa el framework Foundation que proporciona componentes fundamentales de Swift.
// Importa SwiftUI para el soporte de animación y otras funcionalidades relacionadas con la UI.
import Foundation
import SwiftUI

// Define una clase `Obstacle` que hereda de `Sprite` y conforma el protocolo `Identifiable`.
// Esto permite identificar cada instancia de `Obstacle` de forma única.
class Obstacle: Sprite, Identifiable {
    // Crea una propiedad `id` única para cada obstáculo utilizando UUID.
    let id = UUID()
    
    // Declara una propiedad `speed` para representar la velocidad del obstáculo.
    var speed: CGFloat
    
    // Sobrescribe el inicializador para personalizar la inicialización de `Obstacle`.
    override init(center: CGPoint, width: CGFloat, height: CGFloat) {
        // Inicializa la velocidad con un valor aleatorio entre 3 y 6.
        self.speed = CGFloat.random(in: 3...6)
        
        // Llama al inicializador de la clase base (`Sprite`) con los parámetros proporcionados.
        super.init(center: center, width: width, height: height)
    }
    
    // Define una función para mover el obstáculo verticalmente en función de su velocidad.
    func move() {
        withAnimation {
            // Incrementa la posición `y` del obstáculo en función de la velocidad.
            self.center.y += speed
        }
    }
    
    // Restablece la posición del obstáculo cuando supera el límite de la pantalla.
    func restart() {
        // Reinicia la posición `y` del obstáculo al principio (parte superior de la pantalla).
        self.center.y = 0
        
        // Genera una nueva posición `x` aleatoria dentro de los límites de la pantalla.
        self.center.x = CGFloat.random(in: 50..<UIScreen.main.bounds.maxX - 50)
        
        // Genera una nueva velocidad aleatoria para el obstáculo entre 3 y 6.
        self.speed = CGFloat.random(in: 3...6)
    }
}
