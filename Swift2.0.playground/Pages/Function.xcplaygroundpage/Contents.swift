//: [Previous](@previous)
/*:
 ### Function
 */
import Foundation

//: ![The real head of the household?](function1.png)
func sayHelloWorld() -> String {
    return "hello, world"
}
//: ![The real head of the household?](function2.png)
print(sayHelloWorld())
//: ![The real head of the household?](function3.png)
func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}

func sayHello(personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}

print(sayHello("Anna"))
print(sayHello("Brian"))

//: Functions With Multiple Parameters
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHello(personName)
    }
}
print(sayHello("Tim", alreadyGreeted: true)) // 第一個參數沒有參數名

//: Functions With Return Values, return void
func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")

//: ![The real head of the household?](function4.png)
func printAndCount(stringToPrint: String) -> Int {
    print(stringToPrint)
    return stringToPrint.characters.count
}
func printWithoutCounting(stringToPrint: String) {
    printAndCount(stringToPrint)
}
printAndCount("hello, world") //ignored return value
printWithoutCounting("hello, world")

//: Functions with Multiple Return Values (tuple)
func minMax(array: [Int]) -> (min: Int, max: Int) {  //return value is tuple
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax([8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)") //名字已經在函式回傳型別中(tuple)有了定義

//:Optional Tuple Return Types 如果一個return type可能為空, return type可以define為optional(?)
func anotherMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
if let bounds = anotherMinMax([8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

//:Function Parameter Names
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // function body goes here
}
someFunction(1, secondParameterName: 2)//call function時，第一個參數省略名字

//:Specifying External Parameter Names
func someFunction(externalParameterName localParameter: Int) {
    // function body goes here
    print("localParameter is \(localParameter)")
}

func someFunction(externalParameterName2 localParameter: Int) {
    // function body goes here
    print("localParameter 2222 is \(localParameter)")
}

someFunction(externalParameterName: 4) //指定外部參數名稱,但提供了外部參數名稱後,Call function時將會一直需要寫出來
someFunction(externalParameterName2: 4)


//外部參數
func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)"
}
sayHello(to: "zhangsan", and: "lisi")  //to,and 供外面call function時使用

//:Omitting External Parameter Names **_**代替
func someFunction(firstParameterName: Int, _ secondParameterName: Int) {
    // function body goes here
}
someFunction(1, 2)  //省略parameter name

//:Default Prameter Values
func someFunction(parameterWithDefault: Int = 22) {
    // function body goes here

someFunction(6)
someFunction()

//Place parameters with default values at the end of a function’s parameter list.
func someFunctionTest(parameterWithDefault: Int = 22, secondparameter: Int) {
    // function body goes here
}

func someFunctionTestRevert(secondparameter: Int, parameterWithDefault: Int = 22) {
    // function body goes here
}
//someFunctionTest(, secondparameter: 4) //確保在函式呼叫時，非預設參數的順序是一致
someFunctionTestRevert(4)


//:Variadic Parameters 可變參數 在參數列表的最後
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)

//:Constant and Variable Parameters 參數default是常數，可以用var讓參數為變數
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")

//:In-Out Parameters 可變參數不能使用inout, 不能設default value，不能標記let/var
func swapToInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapToInts(&someInt, &anotherInt)
print("someInt is \(someInt)")
print("anotherInt is \(anotherInt)")


//:Function Types
// 第一個型別是 (Int, Int) -> Int
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}

// 第二個型別是 () -> Void typealias Void = ()
func printHelloWorld() {
    print("hello, world")
}

//:Using Function Types
var mathFunction: (Int, Int) -> Int = addTwoInts  // mathFunction/addTwoInts 指向同一個function
print("Result: \(mathFunction(2, 3))")

let anotherMathFunction = addTwoInts //assign a function to a constant or variable
print("Result: \(anotherMathFunction(3,5))")

//:Function Types as Parameter Types
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 6, 5)

//:Function Types as Return Types 你能使用一個函數型別作為另一個函數的Return Types
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}
var currentValue = 3
var moveNearerToZero = chooseStepFunction(currentValue > 0)
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

//:Nested Functions 
// rewrite the chooseStepFunction(_:)function
func anotherChooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 2
    }
    func stepBackward(input: Int) -> Int {
        return input - 2
    }
    
    return backwards ? stepBackward : stepForward
}

currentValue = -4
moveNearerToZero = anotherChooseStepFunction(currentValue > 0)
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
}

//: [Next](@next)
