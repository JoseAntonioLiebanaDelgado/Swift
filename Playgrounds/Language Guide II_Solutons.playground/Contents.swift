import Foundation

/*A01
 Write a function square that takes an Int as input, but doesn't require a label at the call site, i.e. square(3) should work. It should return the square of the input value.
 */
func square(_ value: Int) -> Int {
    return value * value
}

print(square(3))

/*A02
 Write a function whoAmI that takes a name as input parameter. If the name is "Bruce Wayne", the function should return "I am Batman", otherwise return "I am not Batman". The input parameter should have a default value of "Bruce Wayne".
 */

func whoAmI(name: String = "Bruce Wayne") -> String {
    return "I am \(name == "Bruce Wayne" ? "" : "not ")Batman"
}

print(whoAmI(name: "Donald Trump"))
print(whoAmI())

/*A03
 Write a function sum that takes a variable number of integers as input and returns the sum of the numbers.
 */

func sum(values: Int...) -> Int {
    var sum = 0
    for value in values {
        sum += value
    }
    return sum
}

var totalSum = sum(values: 1, 4, 6, 7, 8, 12)
totalSum = sum(values:1)

/*A04
 Crea una función denominada calculateStatistics que reciba como parámetro un array de enteros y retorne el valor máximo, el valor mínimo, la suma de todos los valores y el valor medio.
 Define un array de enteros y utiliza la función calculateStatistics para calcular su valor min, max, la suma y el valor medio. Muestra por consola estos datos calculados.
 Ten en cuenta que si el array de enteros que recibe como parámetro no tiene elementos, no puede devolver valores.
 */

func calculateStatistics(numbers:[Int])->(min:Int, max:Int, sum:Int, avg:Double)?{
        guard !numbers.isEmpty else {return nil}
        let currentMin = numbers.min()! //Unwrap vs optional binding: 100% seguros que  numbers tiene elementos  y por tanto podemos  calcular min
        let currentMax = numbers.max()! //Unwrap vs optional binding: 100% seguros que  numbers tiene elementos  y por tanto podemos  calcular max
        var currentSum = 0
        var avg = 0.0
        for number in numbers{
            currentSum+=number
        }
        avg = Double(currentSum/numbers.count)
        return (currentMin, currentMax, currentSum, avg)
    
}
let numbers = [1,2,3,4]
//or var numbers:[Int]?
if let results = calculateStatistics(numbers: numbers){
    print("Min: \(results.min) Max: \(results.max) Sum:\(results.sum) Avg:\(results.avg)")
}
let numbers = [1,2,3,4]
if let result = [1,]


/*A05
 Crea una función denominada overCutOffValue que reciba un array de enteros y un valor entero de corte (cutOff). Por defecto el valor entero cutOff será 0. Esta función devolverá la diferencia entre el máximo valor del array y el valor de corte cutOff especificado por el usuario, y en ausencia de éste, se usará el valor por defecto.
 Ten en cuenta que si el array de enteros que recibe como parámetro no tiene elementos, no puede devolver valores.

 */
func overCutOffValue(numbers:[Int], cutOff:Int=0)->Int?{
    guard !numbers.isEmpty else {return nil}
    if let max =  numbers.max(){
            return max-cutOff
    }
    return nil
}

if let n = overCutOffValue(numbers: numbers){
    print(n)
}

if let n = overCutOffValue(numbers: numbers, cutOff: 2){
    print(n)
}


/*A06
 Crea una función denominada swapTwoInts que reciba dos valores enteros y los retorne con el valor intercambiado. Usa inout parameters
 
 */
func swapTwoInts (a: inout Int, b: inout Int){
    let temp = a
    a = b
    b = temp
}

var value1 = 3
var value2 = 107
swapTwoInts(a: &value1, b: &value2)
print("value1: \(value1) value2: \(value2)")


/*A07 Escribe una función en Swift que intercambie el primer y último caracter de la string que recibe como parámetro y retorne la string resultante.
*/

func first_last(str1: String) -> String {
    let count = str1.count
    
    if count <= 1{
        return str1
    }
    var result = str1
    let first_char = result.remove(at: result.startIndex)
    let findLast = result.index(before: result.endIndex)
    let last_char = result.remove(at: findLast)
    
    result.append(first_char)
    result.insert(last_char, at: (result.startIndex))
    
    return result
}


print(first_last(str1: "Swift")) //returns twifS
print(first_last(str1: "Apple"))//returns epplA



/*A08
 Cada función tiene un "function type" concreto. Por ejemplo para las funciones
 func addTwoInts(_ a: Int, _ b: Int) -> Int {
     return a + b
 }
 func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
     return a * b
 }
 Su "function type" es (Int, Int) -> Int
 
 Este "function type" podemos asignarlo como tipo  de dato  de una variable:
 var mathFunction: (Int, Int) -> Int
 mathFunction = multiplyTwoInts
 print("Result: \(mathFunction(2, 3))") // Prints "Result: 6"
 mathFunction  = addTwoInts
 print("Result: \(mathFunction(2, 3))") // Prints "Result: 5"
 
 Y también como tipo  de dato de cualquiera de los parámetros de entrada de  una función:
 func printMathResult(_ mathFunctionParameter: (Int, Int) -> Int, _ a: Int, _ b: Int) {
     print("Result: \(mathFunctionParameter(a, b))")
 }
 printMathResult(addTwoInts, 3, 5) // Prints "Result: 8"
 
 Crea una función denonimada add10 que reciba un valor entero  y retone el valor entero sumado a 10. Y crea una función denominada add15 que reciba un valor entero y retorne el valor  entero sumado a 15.
 Crea  una función denominada apply que reciba como parámetros de entrada un  entero y una función del tipo (Int)->(Int), y devuelva el resultado de aplicar al función que reciba como parámetro al valor entero.
 
 // 1
 apply(add10, 8) // 18

 // 2
 apply(add15, 8) // 23
 */

func add10(_ number:Int)->(Int){
    return number+10
}
func add15(_ number:Int)->(Int){
    return number+15
}
func apply (_ mathFunction:(Int)->(Int), _ number:Int)->(Int){
    return mathFunction(number)
}
apply(add10, 8) // 18
apply(add15, 8) // 23

/*A09
 Un "function type" también se puede  utilizar  como tipo de retorno de una función.
 Continuando con la actividad anterior, crea una función denominada compute que reciba como parámetro de entrada un  Bool. Dependiendo de su valor retorne la función add10 o la función add15. Llama la función compute para comprobar su funcionamiento
 */


func compute (decide:Bool)->(Int)->(Int){
    if decide{
        return add10(_:)
    }else{
        return add15(_:)
    }
}

let mathFunction = compute(decide: true)
mathFunction(8) // 18

/*A10
 Considera la siguiente función
 func dayType(for day: String) -> String {
    switch day {
       case: "Saturday", "Sunday": return "Weekend"
       case: "Monday", "Tuesday", "Wednessday", "Thursday", "Friday": return "Weekday"
       default: return "This is not a valid date"
    }
 }
 
 Si la llamada a la función es "Sunday" "Thursday", la función trabaja bien devolviendo el valor correcto
 let result1 = dayType(for: "Sunday") //will return "Weekend"
 let result2 = dayType(for: "Thursday") //will return "Weekday"
 Pero si te equivocas y en lugar de "friday" escribes "fridayys" retornará que no es un valor válido
 let result3 = dayType(for: "fridayys") //will return "This is not a valid date"
 
 Las enumeraciones en este caso pueden ayudarnos a protegernos de este tipo de errores, cuando tenemos un grupo de valores acotado como son los días de la semana. Crea una enumeration denominada Day con todos los días de la semana (Monday, Tuesday, ..., Sunday). Redefine la función dayType para que la use. Llama a esta función para comprobar su funcionamiento
 */

enum Day {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

/** Rewriting the date type function */
func dayType(for day: Day) -> String {
    switch day {
    case Day.Saturday, Day.Sunday:
        return "Weekend"
    case Day.Monday, Day.Tuesday, Day.Wednesday, Day.Thursday, Day.Friday:
        return "Weekday"
    }
}

let result1 = dayType(for: Day.Sunday) //will return "Weekend"


/*A11
 Una enumeration también puede contener métodos. Define la enum AppleDevice con los valores iPad, iPhone, AppleTv, AppleWatch. Define en ella la función description que retorne una String con la descripción de cada dispositivo según el tipo. Llama a esta función.
 */
enum AppleDevice {
    case iPad, iPhone, AppleTv, AppleWatch
    
    func description() -> String {
        switch self {
        case .iPad: return "\(self) was introduced 2006"
        case .iPhone: return "\(self) was introduced 2007"
        case .AppleTv: return "\(self) was introduced 2010"
        case .AppleWatch: return "\(self) was introduced 2014"
        }
    }
}

AppleDevice.iPad.description()    //will return "iPad was introduced 2006"
AppleDevice.iPhone.description()  //will return "iPhone was introduced 2007"


//Otra opción:
/*
  enum AppleDevice: String{
      case iPad = "This is an iPad"
      case iPhone = "This is an iPhone"
      case AppleTv = "This is an AppleTv"
      case AppleWatch = "This is an AppleWatch"
 
      func description() -> String{
          return self.rawValue
      }
  }
 */

/*A12 Un closure es una función swift, pero con una sintaxis más amigable para el desarrollador. Supón  que tenemos la siguiente función:
 func add10(_ number: Int) -> Int {
     return number + 10
 }
 
let valueFunction  = add10(5) //returns 15
 
 Completa  el siguiente código  para crear add10Closure:
 
 let add10Clousure  = ......
 
 let valueClosure  = add10Closure(5) //returns 15
 
 Recuerda que  la sintaxis  de un closure es
 
 { (param1: OneType, param2: AnotherType) -> ReturnType in
     // code
 }
 
 */

let add10Clousure  = {(number:Int)->Int in number+10}
let valueClosure = add10Clousure(5)



/*A13
 Escribe un closure que imprima la String "stuff" y asigna el closure a un variable. Luego llama  al closure.
 */

let printStuff = {print("stuff")}
printStuff()



/*A14
 Escribe un closure que retorne el cuadrado de un valor de entrada. Escribe el closure y la llamada dentro de los paréntesis de la llamada al método print.  print( <write your closure here> ).
 */

print({(a: Double) -> Double in a*a}(2))

/*A15
 El método sorted by de un array devuelve un array ordenado según un criterio. Dado el array
 let nums = [16, 8, 15, 42, 4, 23]
 
 Obten otro array con los elementos ordenados de menor a mayor y de mayor a menor
 */

let nums = [16, 8, 15, 42, 4, 23]
let orderedNums = nums.sorted(by: {(a:Int, b:Int)->Bool in a<b})
print(orderedNums)
let reversedNums = nums.sorted(by: {(a:Int, b:Int)->Bool in a>b})
print(reversedNums)


/*A16
 
 El método filter de un array devuelve un nuevo array con los elementos que cumplen una condición dada.
 Dado el array anterior nums = [16, 8, 15, 42, 4, 23], calcula otro array que contenga solo los números pares de nums.
 */

let evenNumbers = nums.filter { $0 % 2 == 0 }
print(evenNumbers)

/*A17
 
 El método reduce de un array te permite combinar los elementos del array según tus necesidades devolviendo un valor resultado. Usa chatGPT para definir al menos 3 ejemplo de uso de reduce. Recuerda que si no entiendes el código, puedes preguntarle para que te lo explique paso por paso
 */

//Ejemplo 1: Concatenar elementos de un array de cadenas
let words = ["Hola", " ", "mundo", "!"]
let combinedString = words.reduce("") { result, word in
    return result + word
}
print("La cadena combinada es: '\(combinedString)'") // Resultado: "Hola mundo!"

//Ejemplo 2: Calcular el producto de los elementos de un array de enteros
let n = [1, 2, 3, 4, 5]

let product = n.reduce(1) { result, number in
    return result * number
}

print("El producto de los números es \(product)") // Resultado: 120

//Ejemplo 3: Encontrar el máximo valor en un array de enteros
let na = [10, 5, 7, 13, 2]

let maxNumber = na.reduce(Int.min) { result, number in
    return max(result, number)
}

print("El número máximo es \(maxNumber)") // Resultado: 13



/*A18
 El método map de un array aplica una transformación a cada elemento de la colección y devuelve un nuevo array con los resultados. Usa el método map para transformar el rango de valores 1...100 en un array de Strings con el siguiente contenido: "Value 1", "Value 2", .... "Value 100"
 */

let values = Array(1...100).map({"Value \($0)"})
print(values)

/*A19
 El método foreach de un dictionary nos permite iterar sobre cada par clave-valor.
 Dado el dictionary que por cada fruta contiene su precio
 
 let fruitPrices = ["Apple": 2.5, "Banana": 1.2, "Orange": 1.8]
 
 Usa el método foreach para mostrar por consola los precios de cada una de las frutas

 */

let fruitPrices = ["Apple": 2.5, "Banana": 1.2, "Orange": 1.8]
fruitPrices.forEach { key, value in
    print("El precio de \(key) es \(value)€/kg")
}

/*
 A20
 El método filter también existe para dictionaries.
 Dado un dictionary let scores = ["Alice": 85, "Bob": 92, "Charlie": 78, "David": 90] con las puntuaciones de cada uno de los jugadores, crea un array con solo los que superen la puntuación de 80.
 
 */

let scores = ["Alice": 85, "Bob": 92, "Charlie": 78, "David": 90]
let highScorers = scores.filter { $0.value > 80 }
print("Jugadores con más de 80 puntos: \(highScorers)")

