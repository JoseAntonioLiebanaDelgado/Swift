//
//  Cell.swift
//  actividadGrid
//
//  Created by alumne on 28/02/2024.
//

// Importa el framework SwiftUI necesario para construir interfaces de usuario en iOS, macOS, watchOS y tvOS.
import SwiftUI
// Importa KingfisherSwiftUI para manejar la carga y caché de imágenes de la web de manera eficiente.
import KingfisherSwiftUI

// Define `Cell` como una estructura que conforma al protocolo `View`, que es el bloque de construcción básico de la interfaz de usuario en SwiftUI.
struct Cell: View {
    // Declara una variable `item` que espera un objeto `FlickrPhoto`, que probablemente contenga información sobre una foto, como su URL, y posiblemente otros metadatos.
    var item: FlickrPhoto
    
    // Define la propiedad `body`, que SwiftUI utiliza para construir la vista. `some View` indica que devuelve algún tipo que conforma al protocolo `View`.
    var body: some View {
        // `VStack` crea un arreglo vertical de vistas.
        VStack {
            // `KFImage` utiliza Kingfisher para cargar una imagen desde `item.imageURL`. Si `item.imageURL` es nulo, Kingfisher manejará el caso de error internamente.
            KFImage(item.imageURL!)
                .resizable() // Hace que la imagen sea redimensionable.
                .aspectRatio(contentMode: .fit) // Mantiene la relación de aspecto de la imagen y la ajusta dentro del marco asignado.
                
            // `HStack` crea un arreglo horizontal de vistas.
            HStack {
                // Primer icono que representa si la foto es pública. Utiliza un icono de sistema para esto.
                Image(systemName: "person.crop.circle.badge.checkmark")
                .resizable() // Hace el icono redimensionable.
                .aspectRatio(contentMode: .fit) // Mantiene la relación de aspecto del icono.
                .frame(width: 30, height: 30) // Establece el tamaño del icono.
                .foregroundColor(item.ispublic == 1 ? Color.green : Color.red) // Colorea el icono de verde si la foto es pública (`ispublic == 1`), de lo contrario, de rojo.
                
                // Segundo icono que indica si la foto pertenece a un amigo.
                Image(systemName: "person.crop.circle.badge.plus")
                .resizable() // Hace el icono redimensionable.
                .aspectRatio(contentMode: .fit) // Mantiene la relación de aspecto del icono.
                .frame(width: 30, height: 30) // Establece el tamaño del icono.
                .foregroundColor(item.isfriend == 1 ? Color.green : Color.red) // Colorea el icono de verde si la foto es de un amigo, de lo contrario, de rojo.
                
                // Tercer icono que muestra si la foto es de la familia.
                Image(systemName: "person.3")
                .resizable() // Hace el icono redimensionable.
                .aspectRatio(contentMode: .fit) // Mantiene la relación de aspecto del icono.
                .frame(width: 30, height: 30) // Establece el tamaño del icono.
                .foregroundColor(item.isfamily == 1 ? Color.green : Color.red) // Colorea el icono de verde si la foto es de la familia, de lo contrario, de rojo.
            }
        }
    }
}


/* Estructura para la vista previa de `Cell`.
struct Cell_Previews: PreviewProvider {
    // Propiedad estática `previews` que devuelve algún tipo que conforma al protocolo `View`.
    static var previews: some View {
        // Crea una instancia de `FlickrPhoto` con valores de muestra.
        let samplePhoto = FlickrPhoto(
            id: "id", // Sustituye por un valor real
            owner: "owner", // Sustituye por un valor real
            secret: "secret", // Sustituye por un valor real
            server: "server", // Sustituye por un valor real
            farm: 1, // Ajusta según sea necesario
            title: "Sample Photo",
            ispublic: 1,
            isfriend: 0,
            isfamily: 0
        )

        // Usa la instancia de `FlickrPhoto` para proporcionar datos a `Cell`.
        Cell(item: samplePhoto)
    }
}
*/
