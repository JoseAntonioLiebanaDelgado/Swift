// Importa el framework Foundation para obtener acceso a componentes fundamentales.
// Importa SwiftUI para el soporte de animación y otras funcionalidades relacionadas con la UI.
import Foundation
import SwiftUI

// Define una clase `Sprite`, que sirve como una clase base para otros objetos visuales.
class Sprite {
    // Propiedad que define el centro del `Sprite` en coordenadas `x` e `y`.
    var center: CGPoint

    // Propiedad que define el ancho del `Sprite`.
    var width: CGFloat

    // Propiedad que define la altura del `Sprite`.
    var height: CGFloat

    // Computa y devuelve un `CGRect` que representa el marco del `Sprite`.
    var frame: CGRect {
        return CGRect(x: center.x - width / 2,
                      y: center.y - height / 2,
                      width: width,
                      height: height)
    }

    // Inicializa una instancia de `Sprite` con el `center`, `width` y `height` dados.
    init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self.center = center
        self.width = width
        self.height = height
    }

    // Constantes privadas que representan los límites de la pantalla en los ejes `x` e `y`.
    private let minX = UIScreen.main.bounds.minX
    private let maxX = UIScreen.main.bounds.maxX
    private let minY = UIScreen.main.bounds.minY
    private let maxY = UIScreen.main.bounds.maxY

    // Comprueba si el `Sprite` colisiona con los límites de la pantalla.
    func checkScreenCollision() -> Bool {
        return center.x >= maxX || center.x <= minX || center.y >= maxY || center.y <= minY
    }

    // Comprueba si el `Sprite` colisiona con otro `CGRect`.
    func checkCollisionWith(_ frame: CGRect) -> Bool {
        return self.frame.intersects(frame)
    }
}
