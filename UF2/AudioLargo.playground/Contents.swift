import AVFoundation

// Esta clase MyViewModel implementa el protocolo ObservableObject, lo que permite que sus propiedades sean observadas por SwiftUI. Esto es útil para actualizar la interfaz de usuario en respuesta a cambios en los datos.
class MyViewModel: ObservableObject {
    // audioPlayer es una variable opcional de tipo AVAudioPlayer. AVAudioPlayer es una clase en AVFoundation que proporciona una interfaz para la reproducción de sonido.
    // La variable es opcional porque la inicialización de AVAudioPlayer puede fallar si, por ejemplo, el archivo de sonido no se encuentra o tiene un formato incompatible.
    private var audioPlayer: AVAudioPlayer?
    
    // El inicializador init() se llama automáticamente cuando se crea una instancia de MyViewModel.
    init() {
        // Dentro del inicializador, se llama al método setUpSounds() para configurar el reproductor de audio.
        setUpSounds()
    }
    
    // setUpSounds() es un método privado que configura el reproductor de audio. La palabra clave 'private' significa que este método solo puede ser llamado dentro de la definición de clase de MyViewModel.
    private func setUpSounds() {
        // Bundle.main.url(...) intenta localizar el archivo de sonido dentro del paquete de recursos de la aplicación. En este caso, busca un archivo llamado "background.mp3".
        if let soundURL = Bundle.main.url(forResource: "background", withExtension: "mp3") {
            do {
                // Intenta inicializar un objeto AVAudioPlayer con la URL del archivo de sonido. Esta operación puede lanzar un error, por lo que se realiza dentro de un bloque 'do-catch'.
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                // Prepara el reproductor de audio para la reproducción. Este paso es opcional, pero puede mejorar el rendimiento al reducir el retardo entre llamar a play() y el inicio de la reproducción.
                audioPlayer?.prepareToPlay()
                // Establece el número de bucles para la reproducción. Un valor de -1 significa un bucle infinito.
                audioPlayer?.numberOfLoops = Int(-1)
            } catch {
                // Si hay un error al inicializar AVAudioPlayer, el programa ejecuta este bloque. Aquí, se utiliza fatalError(...) para detener la ejecución y reportar el error.
                fatalError("Error al inicializar AVAudioPlayer")
            }
        }
    }
    
    // playSound() es un método público que puede ser llamado desde fuera de la clase para iniciar la reproducción del sonido.
    func playSound() {
        // Llama al método play() en el objeto AVAudioPlayer para comenzar la reproducción. El uso de '?' es necesario porque audioPlayer es opcional; play() solo se llama si audioPlayer no es nil.
        audioPlayer?.play()
    }
}

/*
 Aspectos destacados:

 AVAudioPlayer: Esta clase proporciona funcionalidades más avanzadas para la reproducción de audio en comparación con AudioToolbox. Permite controlar la reproducción de audio, incluyendo pausa, bucle y ajuste de volumen.

 Opcionales: El uso de un opcional (AVAudioPlayer?) es una práctica común en Swift para tipos que pueden ser nil. Esto obliga a manejar casos donde la inicialización puede fallar, mejorando la seguridad del tipo.

 Manejo de errores: El bloque do-catch maneja errores que pueden ocurrir durante la inicialización de AVAudioPlayer. Esto es esencial porque la carga de un archivo de audio puede fallar por varias razones, como archivos corruptos o formatos no soportados.

 Bundle.main.url(...): Este método es crucial para acceder a los recursos empaquetados con la aplicación. Asegúrate de que el archivo "background.mp3" esté correctamente agregado a tu proyecto de Xcode y marcado para ser incluido en el paquete de la aplicación.

 Este enfoque para la reproducción de audio es adecuado para aplicaciones que necesitan un control más detallado sobre el audio, como aplicaciones de música o juegos que requieren efectos de sonido más complejos y música de fondo.
 */
