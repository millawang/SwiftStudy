/*:
 ### Control Flow
 * For In Loops
 * while Loops
 * switch
 */

import UIKit

//:For In Loops
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// 使用 _ 忽略
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
    print(answer)
    
}
print("\(base) to the power of \(power) is \(answer)")

//for in Array
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

// for in Dictionary
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
//:While Loops

var image = UIImage(named: "snakesAndLadders")

let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
// 特殊位置 有梯子的位置 下面0*、+** 都是為了格式整齊，但不是必須
board[03] = +8;  board[06] = +11; board[09] = +9;  board[10] = +2
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    
    //roll the dice
    diceRoll += 1
    if ++diceRoll == 7 {
        diceRoll = 1
    }
    //move by the rolled amount
    square += diceRoll
    if square < board.count {
        //if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
    
}
print("Game over!")

/*:
  Repeat-While
  repeat {
     [statements]
  } while [condition]
  先執行statements，然後執行condition判断，condition==true繼續執行，condition==false結束執行。statements至少被執行一次。
*/
square = 0
diceRoll = 0
repeat {
    square += board[square]
    if ++diceRoll == 7 {
        diceRoll = 1
    }
    square += diceRoll
} while square < finalSquare
print("Game over!")

/*:
 Conditional Statements
 * if
 * switch
 */

//: if
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
//: else
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt")
}
//: else if
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen")
} else {
    print("It's not that cold. Wear a t-shirt")
}

//:Switch  省略break,swift只會執行一個case, one or more values of the same type
image = UIImage(named: "switch.jpg")
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel1")
    break; //雖然不用break，但在特殊情況下想提早跳出switch判斷，也可以使用
    print("\(someCharacter) is a vowel2")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "x", "z":
    print("\(someCharacter) is a consonant")
default: // 平時不能省略除非case包含了所有的值的可能性才能省略
    print("\(someCharacter) is not a vowel or a consonant")
}

enum XX {
    case a
    case b
}

//:Interval Matching
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

//:Tuples
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0): // x任意 y==0
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _): // x==0 y任意
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside the box")
}
image = UIImage(named: "coordinateGraphSimple")
// 是(0,0)的時後，會match所有的case，但是swift只會執行第一次match

//:Value Bindings 變數只能在case中使用
let anotherPoint = (2, 0)

switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis whth a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
image = UIImage(named: "coordinateGraphMedium")

//: Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
image = UIImage(named: "coordinateGraphComplex")

/*:
 Control Transfer Stratements
 continue, break, fallthrough, return
*/
//:Continue
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)

//:Break
let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break //會立即中斷switch
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}

//:Fallthrough 同其他語言中不寫break時的效果, 貫穿下一個case
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2,5:
    description += " hhh"
    fallthrough
case 3:
    description += " aaa "
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
default:
    description += " an integer."
}
print(description)

//:Labeled Statements 在 Swift中，同時使用loop及switch讓continue跟break更明確的指出要停止哪一個動作
//同前一個game
square = 0
diceRoll = 0
gameLoop: while square != finalSquare {
    if ++diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
        case finalSquare:
            // 到達最後一個方塊，遊戲結束
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            // 超出最後一個方塊，再擲一次骰子
            continue gameLoop
        default:
            square += diceRoll
            square += board[square]
    }
}
print("Game over!")

//:Early Exit (return、continue、break、throw)
func greet(person: [String: String]){
    //同if，但else 一定存在
    guard let name = person["name"] else  {
        //print("name is \(name).")
        print("name is \(person["name"]).")
        return
    }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}

greet(["name":"John"])
greet(["name":"Jane", "location": "Cupertino"])

//同上面範例if改寫, 變數使用範圍不同,guard範圍較廣
func greetif(person: [String: String]){
    //同if，但else 一定存在
    if let name = person["name"]{
        print("name is \(name).")
    } else { return }
       // print("outside  name is \(name).")
    if let location = person["location"]  {
        print("I hope the weather is nice near you.")
        return
    } else { return }

}


greetif(["name":"John"])
greetif(["name":"Jane", "location": "Cupertino"])



var temp: Int?
for index in 1...5 {
    guard let tt = temp else {
        break
    }
    print("xxxfff")
}

//:Checking API Availability 可使用值:iOS 8.3 OSX 10.10.3 watchOS
if #available(iOS 9, OSX 10.10, *) {
    // Use iOS9 APIs on iOS， and use OS X v10.10 APIs on OS X
} else {
   // Fall back to earlier iOS and OS X APIs
}

/*: 
 * [Next](@next)
 * [Previous](@previous)
 * [MainPage](First%20Page)
 */
