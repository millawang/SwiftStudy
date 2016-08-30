//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

protocol FirstProtocol {
    // protocol definition goes here
}

protocol AnotherProtocol {
    // protocol definition goes here
    
}

protocol SomeSuperclass {
    // protocol definition goes here
}


struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}
    
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}

protocol SomeProtocol {
    var mustBeSettable: Int { get set } //read, write
    var doesNotNeedToBeSettable: Int { get }  //read
}


protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed{
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

//Mutating Method Requirements
protocol Togglable {
    mutating func toggle() //The mutating keyword is only used by structures and enumerations.
    
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
//lightSwitch 現在的值為 .On

//Initializer Requirements
protocol SomeInitProtocol {
    init(someParameter: Int)
}
class SomeInitClass: SomeInitProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

//override init
protocol SomeOverInitProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeOverInitProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
//Protocols as Types
//class Dice {
//    let sides: Int
//    let generator: RandomNumberGenerator
//    init(sides: Int, generator: RandomNumberGenerator) {
//        self.sides = sides
//        self.generator = generator
//    }
//    func roll() -> Int {
//        return Int(generator.random() * Double(sides)) + 1
//    }
//}
//
//protocol DiceGame {
//    var dice: Dice { get }
//    func play()
//}
//protocol DiceGameDelegate {
//    func gameDidStart(game: DiceGame)
//    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
//    func gameDidEnd(game: DiceGame)
//}



//: [Next](@next)
