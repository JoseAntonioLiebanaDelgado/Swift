//
//  ViewStoreModel.swift
//  gamedummy
//
//  Created by alumne on 10/04/2024.
//


import SwiftUI
// Importa SwiftUI para trabajar con el framework.

class ViewStoreModel: ObservableObject {
    // Declara una clase que se adhiere al protocolo ObservableObject para que pueda ser utilizada como un objeto observable en SwiftUI.

    @Published var center = CGPoint(x: 100, y: 20)
    // Declara una propiedad `center` que contiene un `CGPoint` (coordenadas X e Y).
    // `@Published` permite que SwiftUI detecte cambios y actualice automáticamente las vistas que observan esta propiedad.

    private var displaylink: CADisplayLink?
    // Define una propiedad `displaylink` opcional para almacenar un `CADisplayLink` que se utilizará para sincronizar las actualizaciones de la pantalla.

    private let minX = UIScreen.main.bounds.minX
    private let maxX = UIScreen.main.bounds.maxX
    private let minY = UIScreen.main.bounds.minY
    private let maxY = UIScreen.main.bounds.maxY
    // Define las coordenadas mínimas y máximas de la pantalla usando el tamaño de la pantalla del dispositivo.

    enum Direction {
        case up
        case down
    }
    // Enumera las direcciones posibles para el movimiento vertical: hacia arriba (`up`) y hacia abajo (`down`).

    enum Horizontal {
        case left
        case right
    }
    // Enumera las direcciones posibles para el movimiento horizontal: hacia la izquierda (`left`) y hacia la derecha (`right`).

    private var speed: CGFloat = 2
    // Declara una propiedad `speed` para controlar la velocidad del movimiento del objeto.

    private var direction = Direction.up
    // Establece la dirección vertical inicial como `up` (hacia arriba).

    private var horizontal = Horizontal.right
    // Establece la dirección horizontal inicial como `right` (hacia la derecha).

    func createDisplayLink() {
        displaylink = CADisplayLink(target: self, selector: #selector(gameLoop))
        // Crea un `CADisplayLink` que ejecutará el método `gameLoop` a intervalos regulares.
        displaylink?.add(to: .current, forMode: .default)
        // Añade el `displaylink` al `RunLoop` actual para que empiece a funcionar.
    }

    @objc func gameLoop() {
        // Método llamado regularmente para actualizar la posición del objeto.

        switch direction {
        case .down:
            self.center.y += speed
            // Si la dirección es hacia abajo, aumenta la coordenada `y` por la velocidad (`speed`).
        case .up:
            self.center.y -= speed
            // Si la dirección es hacia arriba, reduce la coordenada `y` por la velocidad (`speed`).
        }

        switch horizontal {
        case .left:
            self.center.x -= speed
            // Si la dirección es hacia la izquierda, reduce la coordenada `x` por la velocidad (`speed`).
        case .right:
            self.center.x += speed
            // Si la dirección es hacia la derecha, aumenta la coordenada `x` por la velocidad (`speed`).
        }

        // Verifica las colisiones con los bordes de la pantalla.
        if (self.center.y >= maxY) {
            // Si el objeto está más allá del borde inferior, cambia la dirección a `up`.
            self.direction = .up
        } else if (self.center.y <= minY) {
            // Si el objeto está más allá del borde superior, cambia la dirección a `down`.
            self.direction = .down
        }

        if (self.center.x >= maxX) {
            // Si el objeto está más allá del borde derecho, cambia la dirección a `left`.
            self.horizontal = .left
        } else if (self.center.x <= minX) {
            // Si el objeto está más allá del borde izquierdo, cambia la dirección a `right`.
            self.horizontal = .right
        }
    }
}

