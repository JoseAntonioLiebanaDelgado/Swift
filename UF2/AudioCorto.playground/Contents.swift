import SwiftUI

import Foundation
import SwiftUI
import AudioToolbox

// Define la clase MyViewModel que implementa el protocolo ObservableObject.
// ObservableObject es un tipo de protocolo usado por SwiftUI para observar los cambios en los datos de los objetos y actualizar la UI automáticamente.
class MyViewModel: ObservableObject {
    // soundID es una variable privada de tipo SystemSoundID, que es un entero sin signo utilizado por Audio Toolbox para representar un sonido del sistema.
    private var soundID: SystemSoundID = 0

    // El inicializador init() se llama cuando se crea una instancia de MyViewModel.
    init() {
        // Dentro del inicializador, llamamos al método setUpSounds() para configurar los recursos de sonido necesarios.
        setUpSounds()
    }

    
    /*
     -El método setUpSounds obtiene la URL del recurso de sonido: La línea if let soundURL: CFURL = Bundle.main.url(forResource: "beep", withExtension: "mp3") as CFURL? { ... } intenta encontrar un archivo de sonido dentro del paquete principal de la aplicación (Bundle.main).
     -El método url(forResource:withExtension:) busca un archivo llamado "beep" con la extensión "mp3". Si se encuentra, la URL de este archivo se almacena en la variable soundURL.
     -Comprobación de la existencia del archivo: La condición if let también verifica que la URL del archivo de sonido realmente exista. Si el archivo "beep.mp3" no se encuentra en el paquete de la aplicación, el cuerpo del if no se ejecutará, evitando así errores por intentar acceder a un recurso inexistente.
     -Creación de un ID de sonido del sistema: Una vez que se ha confirmado la existencia del archivo de sonido y se tiene su URL, se procede a crear un identificador único para este sonido en el sistema usando AudioServicesCreateSystemSoundID(soundURL, &soundID). Este paso es crucial porque asigna el archivo de sonido a un SystemSoundID (soundID), que se utilizará más adelante para reproducir el sonido. AudioServicesCreateSystemSoundID es una función de la API AudioToolbox que toma la URL del archivo de sonido y una referencia a una variable de tipo SystemSoundID donde almacenará el identificador creado.
     -Uso del ID de sonido del sistema para la reproducción: Aunque no se muestra directamente en este fragmento de código, el SystemSoundID (soundID) que se crea y configura aquí se utilizará posteriormente en la aplicación para reproducir el sonido correspondiente al archivo "beep.mp3" mediante la función AudioServicesPlaySystemSound(soundID).
     */
    
    // setUpSounds() es un método privado, lo que significa que solo puede ser llamado dentro de la clase MyViewModel.
    private func setUpSounds() {
        // Intentamos obtener la URL del recurso de sonido llamado "beep" con la extensión "mp3".
        // Bundle.main se refiere al paquete principal de la aplicación, y url(forResource:withExtension:) busca un archivo en este paquete.
        if let soundURL: CFURL = Bundle.main.url(forResource: "beep", withExtension: "mp3") as CFURL? {
            // Si la URL del archivo de sonido existe, entonces procedemos a crear un ID de sonido del sistema utilizando esta URL.
            // AudioServicesCreateSystemSoundID toma la URL del sonido y una referencia a SystemSoundID (soundID) para crear un identificador para el sonido.
            AudioServicesCreateSystemSoundID(soundURL, &soundID)
        }
    }

    // playSound() es un método público que puede ser llamado desde fuera de la clase para reproducir el sonido.
    func playSound() {
        // AudioServicesPlaySystemSound reproduce el sonido asociado con el ID de sonido del sistema.
        // Utiliza el soundID que configuramos en setUpSounds() para reproducir el sonido.
        AudioServicesPlaySystemSound(soundID)
    }
}

/*
 Detalles Importantes:

 ObservableObject: Este protocolo es clave para la integración con SwiftUI, ya que permite que la UI reaccione a los cambios en los datos. En este código, aunque no se observan cambios en las propiedades (con @Published, por ejemplo), la conformidad al protocolo sugiere que se podrían agregar propiedades observables en el futuro.

 SystemSoundID: Es un alias para UInt32 utilizado por el framework Audio Toolbox para representar de manera única los sonidos del sistema. Aquí se inicializa con 0, pero luego se establece con un valor real cuando se carga un archivo de sonido.

 Bundle.main.url(forResource:withExtension:): Este método busca un recurso específico por nombre y extensión en el paquete principal de la aplicación. Es importante que el archivo "beep.mp3" se incluya correctamente en el proyecto y se copie en el paquete de la aplicación para que este método funcione.

 AudioServicesCreateSystemSoundID: Este es un método crucial que asocia un archivo de sonido con un SystemSoundID. Permite al sistema prepararse para reproducir este sonido sin la necesidad de cargarlo de nuevo en memoria cada vez.

 AudioServicesPlaySystemSound: Este método reproduce el sonido indicado por el SystemSoundID. Es una forma sencilla de reproducir sonidos cortos como efectos de sonido en la aplicación.

 Este enfoque es bastante directo para reproducir sonidos simples en una aplicación, aunque tiene limitaciones, como la imposibilidad de controlar el volumen del sonido, pausar o reanudar la reproducción, o reproducir sonidos en segundo plano. Para funcionalidades más avanzadas, se podría considerar el uso de AVAudioPlayer de AVFoundation, como se vio en tu segundo fragmento de código.
 */
