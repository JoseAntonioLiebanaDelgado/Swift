import SwiftUI

// Vista que muestra el estado de una receta (favorita o no)
struct RecipeStatusView: View {
    var isFavorite: Bool  // Indicador de si la receta es favorita

    var body: some View {
        // Mostrar un ícono de estrella lleno si es favorita, o vacío si no
        Image(systemName: isFavorite ? "star.fill" : "star")
            .foregroundColor(isFavorite ? .yellow : .gray)  // Color amarillo si es favorita, gris si no
    }
}
