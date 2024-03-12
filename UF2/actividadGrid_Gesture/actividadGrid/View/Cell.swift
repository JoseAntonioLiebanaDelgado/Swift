//
//  Cell.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework SwiftUI necesario para la interfaz de usuario.
import SwiftUI
// Importa KingfisherSwiftUI para cargar y mostrar imágenes desde la web.
import KingfisherSwiftUI

// Define una estructura llamada Cell que conforma al protocolo View, permitiéndole ser una parte de la interfaz de usuario.
struct Cell: View {
    // 'item' es una variable que almacenará una instancia de FlickrPhoto, un tipo que presumiblemente representa una foto obtenida de Flickr.
    var item: FlickrPhoto
    // La propiedad computada 'body' define el contenido de la vista y su layout.
    var body: some View {
        // VStack organiza sus vistas hijo verticalmente.
        VStack {
            // KFImage carga y muestra una imagen desde una URL usando Kingfisher. La imagen se ajustará para mantener su relación de aspecto.
            KFImage(item.imageURL!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            // HStack organiza las vistas hijo horizontalmente.
            HStack {
                // Crea una imagen del sistema con la forma de un candado dentro de un círculo.
                Image(systemName: "lock.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                // Cambia el color de la imagen a verde si 'ispublic' es 1, de lo contrario a rojo.
                .foregroundColor(item.ispublic == 1 ? Color.green : Color.red)
                
                // Crea una imagen del sistema que representa a una persona y un signo de suma, dentro de un círculo.
                Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                // Cambia el color de la imagen a verde si 'isfriend' es 1, de lo contrario a rojo.
                .foregroundColor(item.isfriend == 1 ? Color.green : Color.red)
                
                // Crea una imagen del sistema que representa a tres personas.
                Image(systemName: "person.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                // Cambia el color de la imagen a verde si 'isfamily' es 1, de lo contrario a rojo.
                .foregroundColor(item.isfamily == 1 ? Color.green : Color.red)
            }
        }
    }
}


/*
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell()
    }
}
*/
