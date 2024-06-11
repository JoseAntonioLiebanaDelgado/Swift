    // Importa el framework SwiftUI para construir la interfaz de usuario.
    import SwiftUI

    // Define una estructura `ContentView` que conforma el protocolo `View`.
    struct ContentView: View {
        // Proporciona acceso al `ViewModel` compartido en el entorno de la aplicación.
        @EnvironmentObject var viewModel: ViewModel

        // Define un gesto de arrastre que actualiza la posición del jugador.
        var dragGesture: some Gesture {
            DragGesture().onChanged { value in
                // Llama a `movePlayer` en el `ViewModel` para mover el jugador a la nueva posición.
                self.viewModel.movePlayer(value.location)
            }
        }

        // Cuerpo que define la interfaz de usuario.
        var body: some View {
            // `GeometryReader` proporciona acceso a las dimensiones de su contenedor.
            GeometryReader { geometry in
                // `ZStack` apila vistas una encima de la otra.
                ZStack {
                    // Muestra el marcador del juego.
                    Text("Score: \(viewModel.score)")

                    // Itera a través de la lista de obstáculos y los muestra como círculos.
                    ForEach(viewModel.obstacles) { obstacle in
                        Circle()
                            // Rellena cada obstáculo con color rojo.
                            .fill(Color.red)
                            // Establece el tamaño de cada obstáculo.
                            .frame(width: obstacle.width, height: obstacle.height)
                            // Posiciona cada obstáculo en su coordenada central.
                            .position(obstacle.center)
                    }

                    // Representa el jugador como un rectángulo azul.
                    Rectangle()
                        // Rellena el rectángulo con color azul.
                        .fill(Color.blue)
                        // Establece el tamaño del rectángulo (jugador).
                        .frame(width: viewModel.player?.width, height: viewModel.player?.height)
                        // Posiciona el rectángulo en la coordenada central del jugador.
                        .position(viewModel.player?.center ?? CGPoint.zero)
                        // Asigna el gesto de arrastre al rectángulo.
                        .gesture(dragGesture)
                }
                // Establece el tamaño del `ZStack` para ocupar todo el espacio disponible.
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                // Se ejecuta cuando la vista aparece por primera vez.
                .onAppear {
                    // Inicializa el jugador con una posición y tamaño predeterminados.
                    viewModel.player = Player(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 2 * 20), width: 100, height: 20)
                    // Inicia el bucle de actualización para el juego.
                    viewModel.createDisplayLink()
                }
                // Muestra una alerta para reiniciar el juego cuando se cumple la condición.
                .alert(isPresented: $viewModel.showRestartAlert) {
                    Alert(
                        title: Text("¿Quieres volver a jugar?"),
                        // Botón para reiniciar el juego.
                        primaryButton: .default(Text("Sí")) {
                            // Llama al método para reiniciar el juego.
                            viewModel.restartGame(geometry: geometry)
                        },
                        // Botón para cancelar.
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }

    // Proporciona una vista de previsualización para el entorno de desarrollo.
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            // Define el contenido de la vista de previsualización.
            ContentView()
        }
    }
