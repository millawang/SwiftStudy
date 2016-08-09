//: [Previous](@previous)
//: ### Opction Chaining

class Person{
    var residence: Residence?
}
class Residence{
    var numberOfRooms = 5
}
let john = Person()

//let roomCount  = john.residence!.numberOfRooms
//this triggers a runtime error

if let roomCount = john.residence?.numberOfRooms {
    print("John 's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

//assign a Residence instance to john.residence, so that it no longer has a nil value
john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John 's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

/*:
 Defining Model Classes for Opeional Chaining
 */
class PersonModel{
    var residence:ResidenceModel?
}
class ResidenceModel{
    var rooms = [Room]()
    var numberOfRooms: Int{
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get{
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
        
    }
    func printNumberOfRooms(){
        print("The number of rooms is \(numberOfRooms)")

    }
    var address:Address?
    
}
class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName:String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil{
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}
/*:
 Accessing Properties Through Opeional Chaining
 */
let millie = PersonModel()
if let roomCount = millie.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
millie.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacoa Road"
    
    return someAddress
}
millie.residence?.address = createAddress()

/*:
 Calling Methods Through Optional Chaining
 */
//The printNumberOfRooms() method on the Residence class
//func printNumberOfRooms() {
//    print("The number of rooms is \(numberOfRooms)")
//}
if millie.residence?.printNumberOfRooms() != nil {
    print("It was possible to print thr number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
if(millie.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
/*:
 Accessing Subscripts Through Opeional Chaining
 */

if let firstRoomName = millie.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
millie.residence?[0] = Room(name: "Bathroom")
let johnsHouse = ResidenceModel()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
millie.residence = johnsHouse

if let firstRoomName = millie.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

//Accessing Subscripts of Optional Type
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
testScores["Dave"]
testScores["Bev"]
testScores["Brian"]
/*:
 Linking Multiple Levels of Chaining
 */
if let johnsStreet = millie.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
millie.residence?.address = johnsAddress

if let johnsStreet = millie.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

/*:
 Chaining on Methods with Optional Return Values
 */
if let buildingIdentifier = millie.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
if let beginsWithThe =
    millie.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}

/*:
 Optional
 */
let name:String? = "twostraws"
let password: String? = "fr0st1les"

switch (name, password){
case let(.Some(name), .Some(password)):
    print("Hello, \(name)")
case let(.Some(name), .None):
    print("Please enter a password")
default:
    print("Who are you?")
    
}


switch (name, password){
case let(.Some(matchName), .Some(matchPassword)):
    print("Hello, \(name), \(matchName)")
case let(.Some(matchName), .None):
    print("Please enter a password")
default:
    print("Who are you?")
    
}

switch (name, password) {
case let(username?, password?):
    print("Hello, \(name) \(username) \(password)")
case let(username?, nil):
    print("Please enter a password")
default:
    print("Who are you?")
    
}


import Foundation
let data: [AnyObject?] = ["Bill", nil, 69, "Ted"]
for case let .Some(datum) in data {
    print(datum)
}
for case let datum? in data {
    print(datum)
}




//: [Next](@next)
