//: [Previous](@previous)
/*: 
 # ARC - Automatic Reference Counting
 * In most cases, this means that memory management “just works” in Swift, and you do not need to think about memory management yourself.
 * ARC automatically frees up the memory used by class instances when those instances are no longer needed.
 * Reference counting only applies to instances of classes. Structures and enumerations are value types, not reference types, and are not stored and passed by reference.
*/

class PersonA {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var reference1: PersonA?
var reference2: PersonA?
var reference3: PersonA?
reference1 = PersonA(name: "John Appleseed")
reference2 = reference1 //strong references
reference3 = reference1 //strong references

//目前還不會被deallocate
reference1 = nil
reference2 = nil
//直到第三個reference被broken時才會clear Person instance
reference3 = nil
//: ### Strong Reference Cycles Between Class Instances
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
    

var john: Person?
var unit4A: Apartment?
    
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
//: ![The real head of the household?](arc1.png)
john!.apartment = unit4A
unit4A!.tenant = john
//: ![The real head of the household?](arc2.png)
john = nil
unit4A = nil
//: ![The real head of the household?](arc3.png)
//The strong references between the Person instance and the Apartment instance remain and cannot be broken.
//: ### Resolving Strong Reference Cycles Between Class Instances
/*:
 * Weak References
 (optional type)
 * Unowned References
 (non-optional type)
 */
//: ### Weak References
class PersonW {
    let name: String
    init(name: String) { self.name = name }
    var apartment: ApartmentW?
    deinit { print("\(name) is being deinitialized") }
}
class ApartmentW {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: PersonW?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var johnW: PersonW?
var unit4AW: ApartmentW?

johnW = PersonW(name: "John Appleseed")
unit4AW = ApartmentW(unit: "4A")

johnW!.apartment = unit4AW
unit4AW!.tenant = johnW
//: ![The real head of the household?](arc4.png)
johnW = nil
//: ![The real head of the household?](arc5.png)
unit4AW = nil
//: ![The real head of the household?](arc6.png)
//: ### Unowned References
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
var johnC: Customer?
johnC = Customer(name: "John Appleseed")
johnC!.card = CreditCard(number: 1234_5678_9012_3456, customer: johnC!)
//: ![The real head of the household?](arc7.png)
john = nil
// prints "John Appleseed is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"
//: ![The real head of the household?](arc8.png)

//: ### Unowned References and Implicitly Unwrapped Optional Properties
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
// prints "Canada's capital city is called Ottawa"
//: ### Strong Reference Cycles for Closures
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// prints"hello, world"
//: ![The real head of the household?](arc9.png)
paragraph = nil  //strong reference 沒有被release
//: ### Resolving Strong Reference Cycles for Closures
//: Defining a Capture List

//: ![The real head of the household?](arc10.png)
//: ![The real head of the household?](arc11.png)

//: Weak and Unowned References
class HTMLElementW {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
var paragraphW: HTMLElementW? = HTMLElementW(name: "p", text: "hello, world")
print(paragraphW!.asHTML())
// Prints "<p>hello, world</p>"
//: ![The real head of the household?](arc12.png)
paragraph = nil
// Prints "p is being deinitialized"
