import SwiftUI

struct RecipeStatusView: View {
    // Propiedad que indica si la receta es favorita.
    var isFavorite: Bool
    
    var body: some View {
        // Imagen de sistema que muestra una estrella llena si es favorita, o una estrella vacía si no.
        Image(systemName: isFavorite ? "star.fill" : "star")
            // Color de la estrella: amarillo si es favorita, gris si no.
            .foregroundColor(isFavorite ? .yellow : .gray)
    }
}
