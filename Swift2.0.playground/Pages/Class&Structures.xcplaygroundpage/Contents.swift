//: [Previous](@previous)

/*:
 ### Classes and Structures
 */
/*: 
### Comparing Classes and Structures
Classes and structures in Swift have many things in common. Both can:
* Define properties to store values
* Define methods to provide functionality
* Define subscripts to provide access to their values using subscript syntax
* Define initializers to set up their initial state
* Be extended to expand their functionality beyond a default implementation
*/

/*: 
 Classes have additional capabilities that structures do not:
 * Inheritance enables one class to inherit the characteristics of another.
 * Type casting enables you to check and interpret the type of a class instance at runtime.
 * Deinitializers enable an instance of a class to free up any resources it has assigned.
 * Reference counting allows more than one reference to a class instance.
 */

/*:
 ### Definition Syntax
 */
class SomeClass {  //大寫命名風格, 有效地定義了一個新的 Swift 型別
    // class definition goes here
}
struct SomeStructure {
    // structure definition goes here
}

//Example
struct Resolution {
    var width = 0
    var heigth = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//The syntax for creating instances is very similar for both structures and classes
let someResolution = Resolution()
let someVideoMode = VideoMode()

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 12880
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

/*:
 ### Structures and Enumerations Are Value Types
 */
let hd = Resolution(width:1920, heigth: 1080)
print("The width of hd is \(hd.width)")

var cinema = hd
cinema.width = 200
print("The width of cinema is \(cinema.width)")
print("hd is still \(hd.width)")
//When cinema was given the current value of hd, the values stored in hd were copied into the new cinema instance.
//兩個完全獨立的instance, 包含有相同的數值

//The same behavior applies to enumerations:
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}

/*:
 ### Classes Are Reference Types
 */
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

/*:
 Identity Operators
 * Identical to (===)
 * Not identical to (!==)
 */
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
    
/*:
 ### Choosing Between Classes and Structures
 * The structure’s primary purpose is to encapsulate a few relatively simple data values.
 * It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
 * Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
 * The structure does not need to inherit properties or behavior from another existing type.
 */

/*:
 ### Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
 */

//: [Next](@next)
