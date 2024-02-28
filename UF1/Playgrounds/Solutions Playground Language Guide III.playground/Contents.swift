import Foundation


/*A01
 Define un struct Point2D que tenga:
 Dos variable stored properties x,y de tipo Double y cuyo valor por defecto sea 0.0
 Una read-only computed property description de tipo String cuyo valor sea "Point x:\(x) y:\(y)".
 Define el objeto aPoint del tipo struct Point2D con x=2.0,y =5.0
 Define el objeto anotherPoint del tipo Struct Point2D con x=0, y=0
 Muestra por consola el valor de la property description de ambos objetos
 */
struct Point2D{
    var x=0.0, y = 0.0
    var description:String{return "Point x:\(x) y:\(y)"}
}

let aPoint=Point2D(x:2.0, y:5.0)
let anotherPoint=Point2D()
print(aPoint.description)
print(aPoint.description)

/*A02
 Modifica el struct Point2D de la actividad anterior, identificándolo como Point2DWithInitializers, de forma que no asigne el valor por defecto de 0.0 a sus stored properties x e y. Implementa los inicializadores con y sin parámetros de entrada que permitan crear los objetos aPoint y anotherPoint de la actividad anterior.
 */

struct Point2DWithInitializers{
    var x:Double
    var y:Double
    var description:String{return "Point x:\(x) y:\(y)"}
    init(){
        self.x=0.0
        self.y=0.0
    }
    init(x:Double, y:Double){
        self.x=x
        self.y=y
    }
}

let cPoint = Point2DWithInitializers()
print(cPoint.description)
let cAnotherPoint = Point2DWithInitializers(x:2.0, y:5.0)
print(cAnotherPoint.description)


/*A03
 Define un struct Circle2D que tenga:
 Una variable stored property center de tipo Point2D struct. Su valor por defecto será un Point2D con x=0.0 e y=0.0
 Una variable stored property radius de tipo Double.
 Una read-only computed property description de tipo String cuyo valor sea "Circle center:\(center.description) radio:\(radius)".
 Un método inicializador que tenga como parámetros el centro (Point2D struct) y el radio (Double)
 Un método inicializador que tenga como parámetro el radio (Double)
 Un método inicializador que tenga como parámetros x (Double), y (Double) y el radio (Double)
 Crea distintos objetos de tipo struct Circle2D usando los distintos inicializadores creados, de cada uno de ellos muestra por consola su descripción y su area
 */

struct Circle2D{
    var center:Point2D=Point2D()
    var radius:Double
    var description:String{return "Circle center:\(center.description) radio:\(radius)"}
    
    init(radius:Double){
        self.radius=radius
    }
    
    init(center:Point2D, radius:Double){
        self.center=center
        self.radius=radius
    }
    
    init(x:Double, y:Double, radius:Double){
        self.center=Point2D(x:x, y:y)
        self.radius=radius
    }
}

var aCircle2D = Circle2D(radius:5.0)
print("\(aCircle2D.description)")

aCircle2D=Circle2D(center:aPoint, radius:5.0)
print("\(aCircle2D.description)")

aCircle2D=Circle2D(x:1.0, y:2.0, radius:5.0)
print("\(aCircle2D.description)")


/*A04
 Define e implementa la clase Calculadora con:
 Dos propiedades de tipo int
 Un método inicializador que permita asignar valor a sus dos propiedades
 Métodos de clase (Type Methods): sumarX:conY, restarX:conY, multiplicarX:conY, dividirX:conY, que recibirán como parámetros dos int y realizaran las operaciones entre los parámetros recibidos que sus nombres indican devolviendo el resultado.
 Métodos de instancia (Instance Methods): sumar, restar, multiplicar, dividir, que realizarán las operaciones que sus nombres indican con las propiedades de la clase, y devolverán el resultado.
 
 Testea que los métodos que has definido en la clase Calculadora realizan las operaciones correctamente. Fíjate en las diferencias entre las llamadas a los métodos de clase y a los métodos de instancia.
 */

class Calculadora{
    var x:Int,y:Int
    init(x:Int, y:Int){
        self.x=x
        self.y=y
    }
    static func sumarX(x:Int, conY y:Int)->Int{ return x+y}
    static func restarX(x:Int, conY y:Int)->Int{ return x-y}
    static func multiplicarX(x:Int, conY y:Int)->Int{ return x*y}
    static func dividirX(x:Int, conY y:Int)->Int{ return x/y}
    
    func sumar()->Int{return self.x+self.y}
    func restar()->Int{return self.x-self.y}
    func multiplicar()->Int{return self.x*self.y}
    func dividir()->Int{return self.x/self.y}
    
}

print(" La suma es \(Calculadora.sumarX(x:2, conY: 3))")
print(" La divisón es \(Calculadora.dividirX(x:2, conY: 3))")

let calculadora=Calculadora(x:2, y:3)
print(" La suma es \(calculadora.sumar())")
print(" La division es \(calculadora.dividir())")

/*
 A05
 Tenemos el siguiente struct Student
 
 struct Student {
     var identifier = 0
     var name: String
     
     init(name: String) {
         self.name = name
     }
 }
 
 Realiza los cambios necesarios para que cada vez que se cree un objeto del tipo Student, su propiedad identifier se incremente en una unidad
 
 let mateo = Student(name: "Mateo") //mateo.identifier = 1
 let ana = Student(name: "Ana") //ana.identifier = 2
 
 */

struct Student {
    var identifier = 0
    var name: String

    static var identifierFactory = 0
    
    static func getUniqueIdentifier()->Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    init(name: String) {
        self.name = name
        self.identifier = Student.getUniqueIdentifier()
    }
}

let mateo = Student(name: "Mateo") //mateo.identifier = 1
let ana = Student(name: "Ana") //ana.identifier = 2


/*A06
 Define el tipo de dato Animal con las siguientes características:
 Stored Property name de tipo String, legs de tipo Int
 Computed Property description de tipo String y cuyo valor sea “\(name) has \(legs) legs”
 Instance method walk() que retornará una String con el texto "\(name) walks on \(legs) legs."
 
 */

struct Animal{
    let name:String
    let legs:Int
    var description:String{return "\(name) has \(legs) legs"}
    func walk()->String{
        return "This animal walks on \(legs) legs"
    }
}
let cat=Animal(name: "cat", legs: 4)
print(cat.description)
print(cat.walk())


/*A07
 Sistema de Alquiler de Libros en una Biblioteca
 Crea un programa en Swift que simule un sistema de alquiler de libros en una biblioteca. Utiliza structs para modelar las entidades clave: libros, usuarios y la biblioteca en sí. El programa debe permitir a los usuarios alquilar libros de la biblioteca y mostrar los libros alquilados por cada usuario.

 Instrucciones
 1-Define struct Book que tenga propiedades para el título, autor y disponibilidad del libro.
 2-Define struct User que tenga propiedades para el nombre del usuario y una lista de libros alquilados. Cuando se crea un usuario no tiene por qué tener libros alquilados.
 3-Define struct Library que contenga una lista de libros disponibles y una lista de usuarios registrados.
 4- Crea un método en struct Library que permita agregar un usuario a la biblioteca.
 5- Crea un método en struct Library que permita a un usuario (registrado) alquilar un libro. Este método debería actualizar la disponibilidad del libro y agregarlo a la lista de libros alquilados del usuario.
6- Desarrolla las sentencias de código donde se creen algunos libros y usuarios, se agreguen a la biblioteca y se realicen al menos tres alquileres de libros por parte de los usuarios.
 7- Muestra los libros alquilados por cada usuario.
 */

struct Book {
    var title: String
    var author: String
    var isAvailable: Bool
}

struct User {
    var name: String
    var borrowedBooks = [Book]()
}

struct Library {
    var availableBooks: [Book]
    var users: [User]

    init(availableBooks: [Book]) {
        self.availableBooks = availableBooks
        self.users = []
    }

    mutating func addUser(_ user: User) {
        users.append(user)
    }

    mutating func borrowBook(user: User, bookTitle: String) {
        // Verificar si el usuario está registrado
        guard let userIndex = users.firstIndex(where: { $0.name == user.name }) else {
                print("\(user.name) no está registrado en la biblioteca. Regístrate antes de alquilar un libro.")
                return
            }
            
            if let bookIndex = availableBooks.firstIndex(where: { $0.title == bookTitle && $0.isAvailable }) {
                availableBooks[bookIndex].isAvailable = false
                users[userIndex].borrowedBooks.append(availableBooks[bookIndex])
                print("\(user.name) ha alquilado el libro '\(bookTitle)'.")
            } else {
                print("Lo siento, el libro '\(bookTitle)' no está disponible para alquilar.")
            }
    }
}

// Crear libros disponibles en la biblioteca
let books = [
    Book(title: "Cien años de soledad", author: "Gabriel García Márquez", isAvailable: true),
    Book(title: "To Kill a Mockingbird", author: "Harper Lee", isAvailable: true),
    Book(title: "1984", author: "George Orwell", isAvailable: true)
]

// Crear la biblioteca
var library = Library(availableBooks: books)

// Crear usuarios
var user1 = User(name: "Juan")
var user2 = User(name: "Maria")

// Agregar usuarios a la biblioteca
library.addUser(user1)
library.addUser(user2)

// Intentar alquilar un libro por parte de un usuario
library.borrowBook(user: user1, bookTitle: "To Kill a Mockingbird")
library.borrowBook(user: user2, bookTitle: "Cien años de soledad")
library.borrowBook(user: user1, bookTitle: "1984")
library.borrowBook(user: user2, bookTitle: "1984")

// Mostrar libros alquilados por cada usuario
for user in library.users{
    print("\(user.name) tiene los siguientes libros alquilados:")
    for book in user.borrowedBooks{
        print("- \(book.title) . Autor: \(book.author)")
    }
}


/*
 A08 Sistema de Gestión de Pedidos en una Cafetería
 Crea un programa en Swift que simule un sistema de gestión de pedidos en una cafetería. Utiliza structs para modelar las entidades clave: productos (cafés, postres, etc.) y pedidos de los clientes. El programa debe permitir a los clientes hacer pedidos y mostrar los detalles de los mismos (incluido el precio total del pedido según los productos).
 Instrucciones:
 1-Define struct Product que tenga propiedades para el nombre del producto y el precio.

 2-Define struct Order que tenga propiedades para el cliente que realizó el pedido (basta con su nombre), la lista de productos pedidos.

 3- Permite que struct Order calcule el importe total del pedido sumando los precios de los productos.

 4- Permite que el struct Order  muestre los detalles del pedido, incluyendo el cliente, la lista de productos y el importe total.

 5- Define las sentencias de código donde se creen algunos productos y se realicen al menos dos pedidos por parte de diferentes clientes.

 6- Muestra los detalles de cada pedido.
 */

struct Product {
    var name: String
    var price: Float
}

struct Order {
    var customer: String
    var products: [Product]
    
    // Método para calcular el precio final del pedido
    var price: Float {
        var totalPrice:Float = 0.0
        for product in products {
            totalPrice += product.price
        }
        return totalPrice
    }

    // Método para mostrar los detalles del pedido
    func displayDetails() {
        print("Cliente: \(customer)")
        print("Productos:")
        for product in products {
            print("- \(product.name): $\(product.price)")
        }
        print("Total: $\(price)")
    }
}

// Crear productos disponibles en la cafetería
let products = [
    Product(name: "Café Americano", price: 2.5),
    Product(name: "Café Latte", price: 3.0),
    Product(name: "Brownie", price: 2.0)
]

// Realizar pedidos
var order1 = Order(customer: "Alice", products: [products[0], products[2]])
var order2 = Order(customer: "Bob", products: [products[1], products[1], products[0]])

// Mostrar detalles de los pedidos
order1.displayDetails()
order2.displayDetails()

