//: [Previous](@previous)

import Foundation

/*: 
 ### Enumeration Syntax
 */
enum SomeEnumeration {
    // enumeration definition goes here
}
enum CompassPoint {
    case North
    case South
    case East
    case West
}

//separated by commas
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Nepturn
}

var directionToHead = CompassPoint.West
directionToHead = .East

switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

//When it is not appropriate to provide a case for every enumeration case, you can provide a default case to cover any cases that are not addressed

let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
somePlanet.hashValue
/*:
 ### Associated Values
 */
enum Value {
    case 整數(Int)
    case 浮點(Float)
    case 字串(String)
}

func describe(value: Value) -> String {
    switch value {
    case .整數(let testInt):
        return "整數: \(testInt)"
    case .浮點(let testFloat):
        return "浮點: \(testFloat)"
    case .字串(let textString):
        return "字串: \(textString)"
    }
}

describe(Value.整數(1234))        //return: "整數: 1234"
describe(Value.浮點(3.14))        //return: "浮點: 3.14"
describe(Value.字串("hello"))     //return: "字串: hello"

//: ![The real head of the household?](barcode_UPC_2x.png)
//: ![The real head of the household?](barcode_QR_2x.png)

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A \(numberSystem), \(manufacturer), \(product), \(check)")
case .QRCode(let productCode):
    print("QR code: \(productCode)")
}

switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A \(numberSystem), \(manufacturer), \(product), \(check)")
case var .QRCode(productCode):
    print("QR code: \(productCode)")
}

/*:
 ### Raw Values
 */
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

//Increment
enum PlanetIncrement: Int {
    case Mercury = 4, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
PlanetIncrement.Jupiter.rawValue
PlanetIncrement.Jupiter.hashValue

enum aCompassPoint: String {
    case North, South, East, West
}
let sunsetDirection = aCompassPoint.West.rawValue

//:Initializing from a Raw Value
let aPossiblePlanet = PlanetIncrement(rawValue: 7)
let positionToFind = 15
if let somePlanet = PlanetIncrement(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

/*:
 ### Recursive Enumerations
 */
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)


let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))

func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

//test without indirect
//enum ArithmeticExpressionWithOutIndirect {
//    case Number(Int)
//    case Addition(ArithmeticExpressionWithOutIndirect, ArithmeticExpressionWithOutIndirect)
//    case Multiplication(ArithmeticExpressionWithOutIndirect, ArithmeticExpressionWithOutIndirect)
//}
//let fiveWithOutIndirect = ArithmeticExpressionWithOutIndirect.Number(5)
//let fourWithOutIndirect = ArithmeticExpressionWithOutIndirect.Number(4)
//let sumWithOutIndirect = ArithmeticExpressionWithOutIndirect.Addition(fiveWithOutIndirect, fourWithOutIndirect)
//
//let productWithOutIndirect = ArithmeticExpressionWithOutIndirect.Multiplication(sumWithOutIndirect, ArithmeticExpressionWithOutIndirect.Number(2))

//: [Next](@next)
