// Importa el framework Foundation, que incluye soporte para fechas y formateo de fechas, entre otras cosas.
import Foundation

// Define la clase 'Utils' que contiene funciones de utilidad.
class Utils{
    // Declara una función estática que convierte un objeto 'Date' en una cadena de texto formateada.
    static func dateformatter(date:Date) -> String {
        // Crea un nuevo objeto 'DateFormatter'.
        let dateFormatter = DateFormatter()
        // Establece el formato de fecha deseado.
        dateFormatter.dateFormat = "dd/MM/yyyy"
        // Convierte la fecha pasada como argumento en una cadena de texto según el formato.
        let dateString = dateFormatter.string(from: date)
        // Devuelve la cadena de texto formateada.
        return dateString
    }
}
