import Foundation

struct Cliente {
    private let nombre: String
    private let apellidos: String
    private let fechaNacimiento: Date
    private(set)var DNI: String
    private var peso: Double
    private var altura: Double
    private let dateFormatter = DateFormatter()

    init?(nombre: String, apellidos: String, fechaNacimiento: String, DNI: String, peso: Double, altura: Double) {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let fecha = dateFormatter.date(from: fechaNacimiento),
              Cliente.calcularEdad(fechaNacimiento: fecha) >= 18,
              Cliente.validarDNI(DNI: DNI),
              peso > 0 && peso < 300,
              altura > 0 && altura < 3 else {
            return nil
        }
        
        self.nombre = nombre
        self.apellidos = apellidos
        self.fechaNacimiento = fecha
        self.DNI = DNI
        self.peso = peso
        self.altura = altura
    }

    var edad: Int {
        return Cliente.calcularEdad(fechaNacimiento: self.fechaNacimiento)
    }
    
    func rangoPeso() -> String {
        let IMC = peso / (altura * altura)
        if IMC < 20 {
            return "Peso insuficiente"
        } else if IMC <= 25 {
            return "Peso normal o saludable"
        } else {
            return "Sobrepeso"
        }
    }
    
    private static func calcularEdad(fechaNacimiento: Date) -> Int {
        let calendar = Calendar.current
        let yearNow = calendar.component(.year, from: Date())
        let yearBirth = calendar.component(.year, from: fechaNacimiento)
        return yearNow - yearBirth
    }
    
    private static func validarDNI(DNI: String) -> Bool {
        return DNI.count == 9
    }
}

class GestorClientes {
    private var clientes: [String: Cliente] = [:]
    
    func alta(cliente: Cliente) {
        if clientes[cliente.DNI] == nil {
            clientes[cliente.DNI] = cliente
        }
    }
    
    func baja(DNI: String) {
        clientes.removeValue(forKey: DNI)
    }
    
    func mostrarClientes() {
        for cliente in clientes.values {
            print("DNI: \(cliente.DNI), Edad: \(cliente.edad), Rango de Peso: \(cliente.rangoPeso())")
        }
    }
}

// Test
let cliente1 = Cliente(nombre: "Juan", apellidos: "Pérez", fechaNacimiento: "01/01/1990", DNI: "12345678Z", peso: 70, altura: 1.75)
let cliente2 = Cliente(nombre: "Ana", apellidos: "López", fechaNacimiento: "01/01/2002", DNI: "87654321A", peso: 60, altura: 1.65)

let gestor = GestorClientes()

if let c1 = cliente1 {
    gestor.alta(cliente: c1)
}

if let c2 = cliente2 {
    gestor.alta(cliente: c2)
}

gestor.mostrarClientes()
gestor.baja(DNI: "12345678Z")
gestor.mostrarClientes()

