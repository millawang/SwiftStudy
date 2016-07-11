//: [Previous](@previous)
/*:
 ### Inheritance
 */
//Base class
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Super makeNoise")

    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

//subclass
class Bicycle: Vehicle {
    // subclass definition goes here」
    
    
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.description
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
/*:
 ### Overriding
 * 子類別可以為繼承來的instance method，class method，instance property，或subscript提供自己定制的implementation
 */
class Train: Vehicle {
    override func makeNoise() {
        super.makeNoise() //super
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()
/*:
 * Accessing Superclass Methods, Properties, and Subscripts
 */
 //super[someIndex], super.someMethod
 /*:
 * Overriding Properties
 * Overriding Property Getters and Setters
 */
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

class SpeedLimitedCar: Car {
    override var gear: Int  {
        get {
            return super.gear
        }
        set {
            super.gear = min(newValue, 40)
        }
    }
}
let speedlimitcar = SpeedLimitedCar()
speedlimitcar.gear = 50
speedlimitcar.currentSpeed = 30.0
print("speedlimitcar: \(speedlimitcar.description)")

/*:
 * Overriding Property Observers
 * Preventing Overrides (final)
 */
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4


//: [Next](@next)
