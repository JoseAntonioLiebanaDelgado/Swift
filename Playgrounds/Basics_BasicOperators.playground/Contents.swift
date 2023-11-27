import Foundation

/*A01 Escribe el código SWIFT equivalente al siguiente código Java
 int matematicas = 10;
 int lenguaCastellana = 8;
 int ingles = 10;
 int ccnn = 10;
 int ccss = 5;
 double media = ((double)(matematicas + lenguaCastellana + ingles + ccnn + ccss))/5;
System.out.println("La nota media es: "+media); //8.6
 
Comprueba que la nota media es un número decimal
 */

let matematicas = 10, lenguaCastellana = 8, ingles = 10, ccnn = 10, ccss = 5
let media = Double(matematicas + lenguaCastellana + ingles + ccnn + ccss)/5
print("La nota media es \(media)")



/*A02 Escribe el código SWIFT que declare e inicialice una variable que contenga el valor de la longitud del lado de un cuadrado y otra variable con el radio de un círculo. Calcula el área del cuadrado y del círculo y muéstralo por consola.
 
 HINT: El número PI es 3.1416….. El tipo de dato Double dispone de la constante Double.pi que permite representar el número PI con todos sus decimales
 */

let lado = 5.0
let radio = 2.0
print("Area del círculo \(Double.pi*pow(radio, 2)). Area del cuadrado \(pow(lado, 2))")


/*A03 Escribe el código SWIFT que dado un número entero, muestre por consola "es par" si es par y "es impar" si es impar. Usa el operador ternario a ? b : c
 
 HINT: un número es par si el resto de dividir por 2 es 0.
 */

let entero = 124
let isPar = entero%2==0 ? "es par" :"es impar"
print(isPar)



/*
 A04
 Declare una tuple que contenga 3 valores Int que usaras para representar una fecha (mes, dia, año).
 Recuerda indicar los nombres de los componentes (month, day, year) para evitar confusiones.
 En una línea lee el día y el mes en dos variables y muestralas por consola
*/

let date = (month:10, day:4, year:2021)
let (day, month)  = (date.day, date.month)
print("Day: \(day) Month: \(month)")


/*A05 La compañía de vuelo LaSalleAir establece que cada pasajero puede subir a bordo una maleta de mano cuyo peso no sobrepase los 10 kg, y tenga unas dimensiones máximas de 55 cm x 40 cm x 20 cm (altura x anchura x profundidad), debido al espacio limitado en cabina. Los pasajeros que superen alguna de estas restricciones tendrán que facturar su equipaje. Escribe el código SWIFT que dado el peso y las dimensiones de una maleta, muestre por consola true si tiene que facturar su maleta de mano o false en caso contrario.
 */

let maleta = (peso : 6, altura : 58, anchura : 45, profundidad : 26)
let facturar = (maleta.peso>10 || maleta.altura>55 || maleta.anchura>40 || maleta.profundidad>20)
print("Tienes que facturar? \(facturar ? "Si": "No")")

/*A06
 Crea una constante llamada parsedInt y asignale el valor Int("10"), que intenta parsear la string 10 y convertirla a Int. Usa Option-Click sobre parsedInt ¿Cual es tipo de tu variable parsedInt?, ¿por qué es optional?
 Cambia el valor de parsedInt a un valor no entero por ejemplo "dog". ¿Cual es el tipo de tu variable parsedInt ahora?
 */

let parsedInt = Int("10")
//let parsedInt = "dog"

/*A07
 Declara una variable del tipo optional String llamada myFavoriteSong. Si tienes una canción favorita, asignale valor a tu variable. Si  tienes más de una canción favorita o no tienes ninguna asignale el valor nil.
 
 Usa optional binding para verificar si tu variable myFavoriteSong contiene valor. Si lo tiene, muestralo por consola. Si no lo tiene muestra un mensaje tipo "I don’t have a favorite song"
 
 Cambia el valor de myFavoriteSong al opuesto del valor que tenga asignado ahora. Si es nil, asignale una string. Si es una string asignale nil. Observa como cambia la salida por consola.

 */

var myFavoriteSong:String? = nil
if let song = myFavoriteSong{
    print("This is my favorite song: \(song)")
}else{
    print("I don’t have a favorite song")
}

/*A08
 Swift permite calcular valores aleatorios Int, Float, Double, incluso Bool de forma muy sencilla usando Range Operators.
 Asi por  ejemplo let number = Int.random(in: 0...10), permite calcular un valor entero  aleatorio entre 0 y 10 ambos incluidos.
 a. Calcula un número entero aleatorio entre 1 y 100, sin incluir el 100
 b. Calcula un número double aleatorio entre 0 y 1, incluidos ambos
 c. Calcula un valor Bool aleatorio

 */

let randomInt = Int.random(in: 1..<100)
let randomDouble = Double.random(in: 0...1)
let randomBool = Bool.random()

/*A09
 Dada una string con el nombre de un usuario y una string con los apellidos de un usuario. Crea una string que contenga el nombre completo. Crea otra string que contenga el nombre y apellidos de otro usuario. Compara los nombres de ambos usuarios (ignore case) mostrando por consola si son iguales o no
 */

var nombre="Manolito"
var apellidos="Gafotas Perez"
let nombreUsuario1 = "\(nombre) \(apellidos)"
nombre = "MANOLITO"
apellidos="Gafotas Perez"
let nombreUsuario2 = "\(nombre) \(apellidos)"
if nombreUsuario1.lowercased()==nombreUsuario2.lowercased(){
    print("Nombres de usuario iguales")
}else{
    print("Nombres de usuario NO iguales")
}


/*A10
 Declara 3 strings, siendo uno de ellos un emoticono. Usa Swift String interpolation para construir otra string con las strings dadas
 */

let str1 = "I"
let str2 = "❤️"
let str3 = "SWIFT"
let string="\(str1) \(str2) \(str3)"

/*
 A11
 Dada la variable distance:

 let distance: UInt = 10
 
 Escribe una sentencia switch usando intervalos que permita lo siguiente:

 Imprima "Here" si distance es 0.
 Imprima "Immediate vicinity" si distance es menor que 5 y mayor que 0.
 Imprima "Near" si distance está entre 5 y 15, incluyendo 15.
 Imprima "Kind of far" si distance es mayor que 15 y menor o igual a 40.
 Imprima "Far" si distance supera 40.
 
 */

let distance: UInt = 10

switch distance {
case 0:
    print("Here")
case 1..<5:
    print("Immediate vicinity")
case 5...15:
    print("Near")
case 16...40:
    print("Kind of far")
default:
    print("Far")
}


/*A12
 Crea un array con 3 strings: “C”, “C++”, “Objective-C”. Añade dos nuevos elementos al array (“Swift”, “Other”) en una única sentencia. Añade un nuevo elemento en la posición 2. Muestra por consola el número de elementos del array. Muestra por consola el índice y el valor de cada item del array. Elimina el elemento “Objective-C” del array
 */

var strArray = ["C","C++","Objective-C"]
strArray+=["Swift","Other"]
strArray.insert("Java", at: 2)
print("strArray has \(strArray.count) elements")

for (index,element) in strArray.enumerated(){
    print("Item \(index) : \(element)")
}

if let index = strArray.firstIndex(of:"Objective-C"){
    print("Eliminado elemento: \(strArray.remove(at:index))")
}

/*A13
 Añade los valores 1138, 1337, y 4711 al final del siguiente array:
 var stuff = [4, 8, 15, 16, 23, 42]
 Usa sólamente una línea de código.
 */

var stuff = [4, 8, 15, 16, 23, 42]
stuff.append(contentsOf: [1138, 1337, 4711])
// Or...
stuff += [1138, 1337, 4711]
// Or...
stuff = stuff + [1138, 1337, 4711]


/*A14 Crea un array de números y calcula la suma de todos los elementos.*/

let numbers = [5, 10, 15, 20]
let sum = numbers.reduce(0, +)
print("La suma de los números es: \(sum)")


/*A15 Crea un diccionario que posteriormente se pueda modificar llamado secretIdentities donde las parejas de clave valor sean "Hulk" -> "Bruce Banner", "Batman" -> "Bruce Wayne", and "Superman" -> "Clark Kent". Muestra por consola la identidad secreta de Batman. Reemplaza la identidad secreta de Hulk con "David Banner".
 */

var secretIdentities = [
    "Hulk": "Bruce Banner",
    "Batman": "Bruce Wayne",
    "Superman": "Clark Kent"
]
if let secretIdentity = secretIdentities["Batman"]{
    print(secretIdentity)
}
secretIdentities["Hulk"] = "David Banner"
if let secretIdentity = secretIdentities["Hulk"]{
    print(secretIdentity)
}


/*A16 Crea un diccionario que mapee nombres de países a capitales y muestra todas las capitales.*/

let capitals = ["Estados Unidos": "Washington D.C.", "Francia": "París", "Japón": "Tokio"]
for (_, capital) in capitals {
    print("Capital: \(capital)")
}


/*A17 Crea dos conjuntos de número. Encuentra la intersección de ambos conjuntos. Encuentra la unión de ambos conjuntos*/

let set1: Set<Int> = [1, 2, 3, 4, 5]
let set2: Set<Int> = [4, 5, 6, 7, 8]
let intersection = set1.intersection(set2)
print("La intersección es: \(intersection)")

let union = set1.union(set2)
print("La unión es: \(union)")

/*A18 Crea un diccionario que contenga nombres de personas y un conjunto de sus intereses. Luego, muestra los intereses de una persona específica. Por ejemplo los intereses de Juan son Musica, Deporte, ... Los de María: Arte, Viajes, ...*/

var interestsDict = ["Juan": Set(["Deportes", "Música"]), "María": Set(["Arte", "Viajes"])]
if let interests = interestsDict["Juan"] {
    print("Intereses de Juan: \(interests)")
} else {
    print("No se encontraron intereses para Juan.")
}

/*Ahora actualiza los intereses de una de las personas*/
interestsDict["Juan"] = Set(["Pintura", "Karate"])
if let interests = interestsDict["Juan"] {
    print("Intereses de Juan: \(interests)")
} else {
    print("No se encontraron intereses para Juan.")
}

/* A19  Dada la variable animal:

 let animal = "tiger"
 
 Escribe por consola:
     "Animal is a tiger" y también "Animal is a cat" si animal es "tiger".
     "Animal is a cat" si animal es "cat".
     "Animal is some other type of animal" si animal no es ni cat ni tiger.
 */

let animal = "tiger"

switch animal {
    case "tiger":
        print("Animal is a tiger")
        fallthrough
    case "cat":
        print("Animal is a cat")
    default:
        print("Animal is some other type of animal")
}

/* A20  Dada la variable edad:

 let age = 25
 
 Escribe por consola:
     "Eres menor de edad" si age es menor que 18
     "Eres adulto joven y tienes una edad par" si age es 18 o superior pero menor que 30 y tu age es par
     "Eres adulto joven y tienes una edad impar" si age es 18 o superior pero menor que 30 y tu age es impar
     "Eres adulto" si age es 30 o superior pero menor que 65
     "Eres un adulto mayor" si age es mayor que 65
 */

let age = -1

if age>=0{
    switch age {
    case ..<18:
        print("Eres menor de edad")
    case 18..<30 where age % 2 == 0:
        print("Eres adulto joven y tienes una edad par")
    case 18..<30 where age % 2 != 0:
        print("Eres adulto joven y tienes una edad impar")
    case 30..<65:
        print("Eres adulto")
    default:
        print("Eres un adulto mayor")
    }
}

