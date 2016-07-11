//: [Previous](@previous)
/*:
 ### Properties
 */
/*:
 ### Stored Properties
 */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int  //define let, 無法在修改
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
/*:
 Stored Properties of Constant Structure Instances
 */
 let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
 // this range represents integer values 0, 1, 2, and 3
 //rangeOfFourItems.firstValue = 6  // 儘管 firstValue 是個變數屬性，這裡還是會報錯
 //ps: struct is value type 所以賦與常數後不能再修改
/*:
 Lazy Stored Properties
 */
class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created

/*:
 Because it is marked with the lazy modifier, the DataImporter instance for the importer property is only created when the importer property is first accessed, such as when its fileName property is queried:
 */
print(manager.importer.fileName)


/*:
 ### Computed Properties
 */
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2) + 1
            let centerY = origin.y + (size.height / 2) + 1
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
        
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 8.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0) //set
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

print("square.origin is now at (\(square.center))") //get
/*:
  Shorthand Setter Declaration
 * newValue
 */
//如上面的例子，沒有newCenter可使用newValue
/*:
  Read-Only Computed Properties
 */
//只有 getter 沒有 setter
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"
/*:
 ### Properties Observers
 * willSet
 * didSet
 */
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
       
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 step
/*:
 ### Global and Local Variables
 */
class StepCounterGlobal {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
    func swapToInts(a: Int) {
        var temporaryA: Int = a{
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    
    
}
let stepCounterGlobal = StepCounterGlobal()
var testLocal = stepCounterGlobal.swapToInts(1)
//testLocal.temporaryA = 300
/*:
 ### Type Properties
 */

/*:
  Type Properties Syntax
 */
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

/*:
 Querying and Setting Type Properties
 */
print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"

