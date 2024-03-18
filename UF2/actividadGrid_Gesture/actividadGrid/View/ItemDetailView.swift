//
//  ItemDetailView.swift
//  actividadGrid
//
//  Created by alumne on 06/03/2024.
//

// Importa el framework SwiftUI necesario para la interfaz de usuario.
import SwiftUI
// Importa KingfisherSwiftUI para cargar y mostrar imágenes desde la web.
import KingfisherSwiftUI

// Define una estructura llamada ItemDetailView que conforma al protocolo View, permitiéndole ser una parte de la interfaz de usuario.
struct ItemDetailView: View {
    // 'item' es una variable que almacenará una instancia de FlickrPhoto, un tipo que presumiblemente representa una foto obtenida de Flickr.
    var item: FlickrPhoto
    // '@State' marca 'isLikedPhoto' para el almacenamiento de estado, permitiendo que la vista se actualice cuando este cambie.
    @State var isLikedPhoto: Bool = false
    // '@State' para 'scale', que controlará el nivel de zoom de la imagen.
    @State var scale: CGFloat = 1
    // '@State' para 'hideIconsInfoPhoto', que controlará la visibilidad de los íconos de información.
    @State var hideIconsInfoPhoto: Bool = false
    
    // Define una propiedad computada 'magnificationGesture' para manejar gestos de magnificación en la imagen.
    var magnificationGesture: some Gesture {
       return MagnificationGesture()
        .onChanged { value in
            // Actualiza 'scale' basado en el gesto de magnificación, y oculta los íconos de información.
            self.scale = value.magnitude
            self.hideIconsInfoPhoto = true
        }
        .onEnded { _ in
            // Restablece 'scale' a 1 y muestra los íconos de información cuando el gesto termina.
            self.scale = 1
            self.hideIconsInfoPhoto = false
        }
    }
    
    // La propiedad computada 'body' define el contenido de la vista y su layout.
    var body: some View {
        // VStack organiza sus vistas hijo verticalmente.
        VStack {
            // KFImage carga y muestra una imagen desde una URL usando Kingfisher. La imagen se puede ampliar y se le puede dar doble toque para "me gusta".
            KFImage(item.imageURL!)
                .resizable() // Hace que la imagen sea redimensionable, lo que permite cambiar su tamaño.
                .aspectRatio(contentMode: .fit) // Mantiene la relación de aspecto de la imagen y la ajusta dentro del marco disponible.
                .onTapGesture(count: 2) {
                    // Define un gesto de toque con un conteo de 2, es decir, un doble toque.
                    // Cambia el estado de 'isLikedPhoto' al dar doble toque, lo que indica si la foto es "me gusta" o no.
                    self.isLikedPhoto.toggle()
                }
                .scaleEffect(scale) // Aplica un efecto de escala a la imagen, basado en el valor de 'scale'. Útil para el zoom.
                .gesture(magnificationGesture) // Aplica un gesto de magnificación, que probablemente permita a los usuarios pellizcar para hacer zoom.
                .overlay(
                    // Superpone elementos sobre la imagen. En este caso, se añade una capa encima de la imagen.
                    VStack {
                        HStack {
                            Spacer() // Empuja el contenido hacia el lado opuesto en una HStack, aquí mueve el corazón a la derecha.
                            Image(systemName: "heart.fill") // Muestra un icono de corazón lleno.
                                .resizable() // Hace que el icono de corazón sea redimensionable.
                                .aspectRatio(contentMode: .fit) // Mantiene la relación de aspecto del icono del corazón y lo ajusta dentro de su marco.
                                .frame(width: 30, height: 30) // Define el tamaño del marco para el icono del corazón.
                                .foregroundColor(self.isLikedPhoto ? Color.green : Color.gray) // Cambia el color del corazón a verde si 'isLikedPhoto' es verdadero, de lo contrario es gris.
                                .padding(20) // Añade un relleno alrededor del icono del corazón, lo que incrementa su área táctil y lo separa de los bordes.
                        }
                        Spacer() // En una VStack, esto empuja el contenido hacia arriba.
                    }
                )
            // HStack organiza las siguientes vistas horizontalmente.
            HStack {
                // Íconos de información que indican si la foto es pública, de un amigo o familiar. Su opacidad cambia con 'hideIconsInfoPhoto'.
                Image(systemName: "lock.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.ispublic == 1 ? Color.green : Color.red)
                .opacity(hideIconsInfoPhoto ? 0 : 1)
                
                Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.isfriend == 1 ? Color.green : Color.red)
                .opacity(hideIconsInfoPhoto ? 0 : 1)
                
                Image(systemName: "person.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(item.isfamily == 1 ? Color.green : Color.red)
                .opacity(hideIconsInfoPhoto ? 0 : 1)
            }
        }
    }
}


/*
struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
 */
