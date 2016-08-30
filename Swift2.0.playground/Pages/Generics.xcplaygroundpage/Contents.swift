//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//:non-generic function
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//:swap two String values, or two Double values
func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//一次搞定
func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
/*: 
 * both a and b must be of the same type
* func swapTwoInts(inout a: Int, inout _ b: Int)
* func swapTwoValues<T>(inout a: T, inout _ b: T)
*/
swapTwoValues(&someInt, b: &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, b: &anotherString)
// someString is now "world", and anotherString is now "hello"

struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
//:可以使用任何有效的識別符號來作為型別參數名，通常用一單個字母T來命名型別參數
struct Stack<K> {
    var items = [K]()
    mutating func push(item: K) {
        items.append(item)
    }
    mutating func pop() -> K {
        return items.removeLast()
    }
}

//:Type Constraint
func compareInt(a: Int, b: Int) -> Bool {
    return a > b
}

func compareString(a: String, b: String) -> Bool {
    return a > b
}

//func compare<T>(a: T, b: T) -> Bool {
//    return a > b    //error: error: binary operator '>' cannot be applied to two T
//}
func compare<T: Comparable>(a: T, b: T) -> Bool {
    return a > b
}

compare(1, b: 2)           //return: false
compare(3.14, b: 2.71)     //return: true
compare("foo", b: "bar")   //return: true

class Person {
    var age: Int
    init(age: Int) {
        self.age = age
    }
}

//compare(Person(age: 35), b: Person(age: 20)) ////error: error: cannot invoke 'compare' with an argument list of type '(Person, Person)'

//:使用extension擴充Person的有關Comparable功能
extension Person: Comparable {}

func ==(a: Person, b: Person) -> Bool {
    return a.age == b.age
}

func <(a: Person, b: Person) -> Bool {
    return a.age < b.age
}

var p1 = Person(age: 10)
var p2 = Person(age: 20)
compare(p1, b: p2)

//能夠比較Person好像沒什麼，但當我們想排序陣列，Comparable就幫上很大的忙，讓程式簡潔又邏輯清楚，是不是很神奇呢？
var numbers = [1, 3, 2, 4]
numbers.sort(<)     //return: [1, 2, 3, 4]

var persons = [Person(age: 15), Person(age: 44), Person(age: 37)]
persons.sort(<)     //return: [{age 15}, {age 37}, {age 44}]

//:Generic Struct
struct IntQueue {
    var items = [Int]()
    
    mutating func enqueue(item: Int) {
        items.append(item)
    }
    mutating func dequeue() -> Int? {
        return items.count > 0 ? items.removeAtIndex(0) : nil
    }
}

var iq = IntQueue()
iq.enqueue(1)       //return: {[1]}
iq.enqueue(2)       //return: {[1, 2]}
iq.enqueue(3)       //return: {[1, 2, 3]}
iq.dequeue()        //return: 1
iq.dequeue()        //return: 2
iq.dequeue()        //retrun: 3
iq.dequeue()        //return: nil

struct StringQueue {
    var items = [String]()
    
    mutating func enqueue(item: String) {
        items.append(item)
    }
    mutating func dequeue() -> String? {
        return items.count > 0 ? items.removeAtIndex(0) : nil
    }
}

var sq = StringQueue()
sq.enqueue("foo")   //return: {["foo"]}
sq.enqueue("bar")   //return: {["foo", "bar"]}
sq.enqueue("qiz")   //return: {["foo", "bar", "qiz"]}
sq.dequeue()        //return: "foo"
sq.dequeue()        //return: "bar"
sq.dequeue()        //return: "qiz"
sq.dequeue()        //return: nil

//:套用 Generic Type 的struct人生變成彩色的。
struct Queue<T> {
    var items = [T]()
    
    mutating func enqueue(item: T) {
        items.append(item)
    }
    mutating func dequeue() -> T? {
        return items.count > 0 ? items.removeAtIndex(0) : nil
    }
}

var giq = Queue<Int>()
giq.enqueue(1)       //return: {[1]}
giq.enqueue(2)       //return: {[1, 2]}
giq.enqueue(3)       //return: {[1, 2, 3]}
giq.dequeue()        //return: 1
giq.dequeue()        //return: 2
giq.dequeue()        //retrun: 3
giq.dequeue()        //return: nil

var gsq = Queue<String>()
gsq.enqueue("foo")   //return: {["foo"]}
gsq.enqueue("bar")   //return: {["foo", "bar"]}
gsq.enqueue("qiz")   //return: {["foo", "bar", "qiz"]}
gsq.dequeue()        //return: "foo"
gsq.dequeue()        //return: "bar"
gsq.dequeue()        //return: "qiz"
gsq.dequeue()        //return: nil

//:Generic Function
//:定義 Function 接受特定類型的物件，並可搭配where額外限目標制物件必須符合哪些protocol。
protocol Eatable {}
protocol Delicious {}
protocol Disgusting {}

class Stuff {}
class Stone: Stuff {}
class Food: Stuff, Eatable {}
class DeliciousFood: Food, Delicious {}
class DisgustingFood: Food, Disgusting {}

func eat<T: Stuff where T: Eatable>(food: T) {}

eat(Food())
eat(DeliciousFood())
eat(DisgustingFood())
//eat(Stone())    //error: cannot invoke 'eat' with an argument list of type '(Stone)'

//:Generic Class 實作方式與 Struct 大同小異，就差在繼承機制而已
protocol Colorful {
    var color: String { get }
}

class Box {}
class ColorBox: Box, Colorful {
    var color: String
    init(color: String) {
        self.color = color
    }
}

class Ball {}
class ColorBall: Ball, Colorful {
    var color: String
    init(color: String) {
        self.color = color
    }
}

struct GQueue<T: Box where T: Colorful> {
    var items = [T]()
    
    mutating func enqueue(item: T) {
        items.append(item)
    }
    mutating func dequeue() -> T? {
        return items.count > 0 ? items.removeAtIndex(0) : nil
    }
    func countColorItems(color: String) -> Int {
        return items.reduce(0) { $1.color == color ? $0 + 1 : $0 }
    }
}

var queue = GQueue<ColorBox>()
queue.enqueue(ColorBox(color: "red"))
queue.enqueue(ColorBox(color: "blue"))
queue.enqueue(ColorBox(color: "red"))
queue.enqueue(ColorBox(color: "blue"))
queue.countColorItems("red")  //return: 2

//queue.enqueue(ColorBall(color: "yellow"))   // error: cannot invoke 'enqueue' with an argument list of type '(ColorBall)'




//: [Next](@next)
