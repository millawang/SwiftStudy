//: [Previous](@previous)

/*:
 ### Methods
 */
/*:
 ### Instance Methods
 */
class Counter {
    var count = 0
    func increment() {
        self.count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
// 初始計數值是0
counter.increment()
// 計數值現在是1
counter.incrementBy(5)
// 計數值現在是6
counter.reset()
// 計數值現在是0
/*:
 ### The self Property
 */
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(3.0) {
    print("This point is to the right of the line where x == 1.0")
}

/*:
 ### Modifying Value Types from Within Instance Methods
 */
struct PointMutating {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    func moveByX2(deltaX: Double, y deltaY: Double) {
        //x += deltaX
        //y += deltaY
        
    }

}
var somePointMutating = PointMutating(x: 1.0, y: 1.0) //注意不能定義成常數
somePointMutating.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePointMutating.x), \(somePointMutating.y))")
/*:
 ### Assigning to self Within a Mutating Method
 */
struct PointSelf {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = PointSelf(x: x + deltaX, y: y + deltaY)
    }
    
    
}
var somePointSelf = PointSelf(x: 3.0, y: 2.0)
somePointSelf.moveByX(3.0, y: 2.0)
print("The point is now at (\(somePointSelf.self.x), \(somePointSelf.y))")
//Enum
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 現在等於 .High
ovenLight.next()
// ovenLight 現在等於 .Off
/*:
 ### Type Methods
 */
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
        print("someTypeMethod")
    }
    static func antherTypeMethod(){
        print("antherTypeMethod")
    }
}
SomeClass.someTypeMethod()
SomeClass.antherTypeMethod()

//Game
struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
//player.completedLevel(6)
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

//: [Next](@next)
