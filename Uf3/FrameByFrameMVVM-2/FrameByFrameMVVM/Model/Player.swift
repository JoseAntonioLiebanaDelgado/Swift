// Importa el framework Foundation para obtener acceso a componentes fundamentales.
// Importa SwiftUI para el soporte de animación y otras funcionalidades relacionadas con la UI.
import Foundation
import SwiftUI

// Define una clase `Player` que hereda de `Sprite`.
class Player: Sprite {
    // Define una función para mover el `Player` a un nuevo punto (`CGPoint`).
    func moveToPoint(_ point: CGPoint) {
        // Aplica una animación a la actualización de la posición.
        withAnimation {
            // Actualiza la posición horizontal (`x`) del jugador al nuevo punto.
            self.center.x = point.x
        }
    }
}
