//: [Previous](@previous)

import Foundation

//:Closure Expressions
/*:The Sort Function
 */
// sort(_:)
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)
names
/*:Closure Expression Syntax
 */
//: ![The real head of the household?](ClosureExpressionSyntax.png)
reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//:簡化過程
/*:Inferring Type From Context */
reversed = names.sort({ s1, s2 in return s1 > s2 })
/*:Implicit Returns from Single-Expression Closures */
reversed = names.sort({ s1, s2 in s1 > s2 }) //知道sort要一個boolean值，直接省略return
/*:Shorthand Argument Names*/
reversed = names.sort({ $0 > $1 }) //知道要有二個參數 直接簡化成這樣
/*:Operator Functions*/
reversed = names.sort(>) //直接都省略由編譯器來推算
/*:Trailing Closures*/
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}
someFunctionThatTakesAClosure({
    // closure's body goes here
})

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
someFunctionThatTakesAClosure {
    // trailing closure's body goes here
}
reversed = names.sort() { $0 > $1 }
// 還可以連()都省略
reversed = names.sort { $0 > $1 }

/*:Capturing Values*/
var str = "Hello, playground"
//:在Closure函式的外層所宣告的變數，其值仍可被該Closure函式所讀取(capture)
//宣告一個returnFunc函式，其回傳值是一個(Int) -> () 的函式
func returnFunc() -> (Int) -> () {
    var counter = 0  // counter這個變數待會兒可在下方的innerFunc closure 中被capture
    func innerFunc(i: Int) {
        //可讀取到counter這個變數，這個變數位在innerFunc closure外部，這個動作我們稱為capture
        counter += i
        print("running total is now \(counter)")
    }
    return innerFunc
}

let f = returnFunc()
f(3)  //會印出"running total is now 3"
f(4)  //會印出"running total is now 7"
//如果我們重新呼叫returnFunc，counter的值會重新開始計算
let g = returnFunc()
g(2)  //會印出"running total is now 2"
g(2)  //會印出"running total is now 4"
//不過，雖然重新呼叫returnFunc，但是counter值並不會相互影響，因為它們屬於不同的變數
f(2)  //會印出"running total is now 9"
/*:Closures Are Reference Types*/
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
let incrementByTen = makeIncrementor(forIncrement: 10)
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
/*:Nonescaping Closures*/
var completionHandlers: [() -> Void] = []
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
    closure()
    //completionHandlers.append(closure) // error
}



//: [Next](@next)
