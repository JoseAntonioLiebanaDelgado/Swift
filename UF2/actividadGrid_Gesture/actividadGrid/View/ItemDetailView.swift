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
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture(count: 2) {
                    // Cambia el estado de 'isLikedPhoto' al dar doble toque.
                    self.isLikedPhoto.toggle()
                }
                .scaleEffect(scale) // Aplica el efecto de escala basado en 'scale'.
                .gesture(magnificationGesture) // Aplica el gesto de magnificación.
                .overlay(
                    // Superpone un corazón que indica si la foto es "me gusta" o no.
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(self.isLikedPhoto ? Color.green : Color.gray)
                                .padding(20)
                        }
                        Spacer()
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
