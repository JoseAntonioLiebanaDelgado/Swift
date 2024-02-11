// Importa el framework SwiftUI necesario para construir la interfaz de usuario.
import SwiftUI

// Define la estructura 'DetailFruitView' que conforma al protocolo 'View'.
struct DetailFruitView: View {
    // Declara una propiedad constante 'fruit' para almacenar la información de la fruta que se mostrará.
    let fruit: Fruit
    
    // Define el cuerpo de la vista 'DetailFruitView'.
    var body: some View {
        // Crea un VStack que organiza las vistas verticalmente con un espaciado de 20 puntos.
        VStack(spacing: 20.0) {
            // Muestra la descripción de la fruta, con alineación de texto centrada y un estilo de fuente 'title3'.
            Text(fruit.description)
                .multilineTextAlignment(.center)
                .font(.title3)
            
            // Usa 'GeometryReader' para leer las dimensiones del contenedor actual y ajustar el contenido en consecuencia.
            GeometryReader { geometry in
                // Crea un ZStack para superponer vistas, con el texto del emoji de la fruta sobre un círculo.
                ZStack {
                    // Dibuja un círculo con un borde y una sombra.
                    Circle().strokeBorder(Color.gray.opacity(0.15), lineWidth: 10)
                        .shadow(radius: 10, x: 5, y: 5)
                    // Muestra el emoji de la fruta, ajustando el tamaño de la fuente según las dimensiones disponibles.
                    Text("\(fruit.emoji.rawValue)")
                        .font(.system(size: geometry.size.height > geometry.size.width ? geometry.size.width * 0.4 : geometry.size.height * 0.4))
                }
            }.frame(maxWidth: 250) // Limita el ancho máximo del 'GeometryReader' a 250 puntos.
            
        }.padding() // Aplica un relleno alrededor del VStack para separarlo de los bordes de la pantalla.
    }
}

// Define una vista previa para 'DetailFruitView'.
struct DetailFruitView_Previews: PreviewProvider {
    static var previews: some View {
        // Muestra 'DetailFruitView' con una fruta predeterminada en modo claro.
        DetailFruitView(fruit: FruitStore.defaultFruit)
        // Muestra 'DetailFruitView' con una fruta predeterminada en modo oscuro.
        DetailFruitView(fruit: FruitStore.defaultFruit)
            .preferredColorScheme(.dark)
        // Muestra 'DetailFruitView' con una fruta predeterminada en un layout fijo de 480x320.
        DetailFruitView(fruit: FruitStore.defaultFruit)
            .previewLayout(.fixed(width: 480, height: 320))
    }
}
