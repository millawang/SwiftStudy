//: [Previous](@previous)
//: # Initalization
struct Fahrenheit {
    var temperature: Double
    init() { //建構子
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

//你可以使用更簡單的方式在定義結構Fahrenheit時為屬性temperature設置預設值
struct FahrenheitB {
    var temperature = 32.0
}

/*:
 ## Customizing Initialization
 */
struct CelsiusA {
    var temperatureInCelsius: Double
    
    //Initialization Parameters 1
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    //Initialization Parameters 2
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = CelsiusA(fromFahrenheit: 212.0)
print("freezingPointOfWater.temperatureInCelsius is \(boilingPointOfWater.temperatureInCelsius)")
let freezingPointOfWater = CelsiusA(fromKelvin: 273.15)
print("freezingPointOfWater.temperatureInCelsius is \(freezingPointOfWater.temperatureInCelsius)")

//: ### Local and External Parameter Names
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
// External names are required
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
//let veryGreen = Color(0.0, 1.0, 0.0) // this reports a compile-time error - external names are required
//: ### Initializer Parameters Without External Names
struct Celsius {
    var temperatureInCelsius: Double
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
//:### Assigning Constant Properties During Initialization
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"
//: ## Default Initializers
//: Because all properties of the ShoppingListItem class have default values, and because it is a base class with no superclass, ShoppingListItem automatically gains a default initializer
class ShoppingListItema {
    var name: String?  //default nil
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItema()
//: ### Memberwise Initializers for Structure Types
// 没有 custom initializers時
struct SizeA {
    var width = 0.0, height = 0.0
}
let twoByTwo = SizeA(width: 2.0, height: 2.0)

//: ### Initializer Delegation for Value Type
//Initializer Delegation: 初始化程序再去呼叫別的初始化程序
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
print("basicRect 的原點是 (\(basicRect.origin.x), \(basicRect.origin.y)) ")
print("basicRect 的尺寸是 (\(basicRect.size.width), \(basicRect.size.height)) ")

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))
print("originRect 的原點是 (\(originRect.origin.x), \(originRect.origin.y)) ")
print("originRect 的尺寸是 (\(originRect.size.width), \(originRect.size.height)) ")

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),size: Size(width: 3.0, height: 3.0))
print("centerRect 的原點是 (\(centerRect.origin.x), \(centerRect.origin.y)) ")
print("centerRect 的尺寸是 (\(centerRect.size.width), \(centerRect.size.height)) ")

//: ### Initializer Delegation for Class
/*: 
 ### designated initializer
 * Every class must have at least one designated initiali*:zer.
 */
//: ![The real head of the household?](design.png)
/*:
 ### convenience initializer
 * Convenience initializers are secondary, supporting initializers for a class.
 * You do not have to provide convenience initializers if your class does not require them.
 */
//: ![The real head of the household?](convenience.png)

/*: ### Relationships between designated and convenience
 * Convenience initializers的建構過程中，必須委任類別本身中的另一個initializers(可以是designated initializers或convenience initializers)。
 * Convenience initializers可以一直委任另一個Convenience initializers(一個接著一個)，但最後必須要委任一個designated initializers。
 * designated initializers必須要委任其父類別的designated initializers(如果有父類別的話)。
 */
/*: 
 一個簡單的記憶方法
 * Designated initializers must always delegate up.
 * Convenience initializers must always delegate across.
 */
 
//: ![The real head of the household?](class_init.png)[#Image(imageLiteral: "up_init.png")#]
/*: 
 ### Two-Phase Initialization
 * Convenience initializer 第一步必需是呼叫 Designated initializer(self.init)；
 * Designated initializer 第一步是初始化所有 stored properties，接著必需呼叫 super 的 Designated initializer。
 */
/*:
Safety check
* 1.Designated initializer必須保證它所在類別引入的所有properties都必須先初始化完成，之後才能將其它init任務向上代理給父類別中的initializer。如上所述，一個物件的內存只有在其所有儲存型屬性確定之後才能完全初始化。為了滿足這一規則，指定initializer必須保證它所在類別引入的屬性在它往上代理之前先完成化。
* 2.Designated initializer必須先向上代理呼叫父類別initializer，然後再為繼承的屬性設置新值。如果沒這麼做，Designated initializer賦予的新值將被父類別中的建構器所覆蓋。
* 3.Convenience initializer必須先代理呼叫同一類別中的其它initializer，然後再為任意屬性賦新值。如果沒這麼做，Convenience initializer賦予的新值將被同一類別中其它指定建構器所覆蓋。
* 4.initializer在第一階段建構完成之前，不能呼叫任何實例方法、不能讀取任何實例屬性的值，也不能參考self的值。
*/
//: ![The real head of the household?](up_init.png)
//: ![The real head of the household?](down_init.png)
//: ### Initializer Inheritance and Overriding
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
//: ![The real head of the household?](override_init.png)
let namedMeat = Food(name: "Bacon")
// namedMeat 的名字是 "Bacon」
print("name is \(namedMeat.name)")
let mysteryMeat = Food()
print("name is \(mysteryMeat.name)")

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    convenience override init(name: String) {
        self.init(name: name, quantity: 2)
    }
}
//: ![The real head of the household?](inherited_init.png)
let oneMysteryItem = RecipeIngredient()
print("oneMysteryItem has \(oneMysteryItem.quantity) \(oneMysteryItem.name)")
let oneBacon = RecipeIngredient(name: "Bacon")
print("oneBacon has \(oneBacon.quantity) \(oneBacon.name)")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
print("sixEggs has \(sixEggs.quantity) \(sixEggs.name)")

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
breakfastList[2].purchased = true

for item in breakfastList {
    print(item.description)
}
// 2 x Orange juice ✔
// 2 x Bacon ✘
// 6 x Eggs ✘
//: ![The real head of the household?](2override_init.png)
/*:
 ### Failable Initializers
 * 可失敗的(Failable Initializer)初始化方法 init?()，return nil 表示初始化失敗，在實例化時是一個 optional 值。
 * Failable Initializer 的 Initializer Delegation 跟其他初始化方法的 Initializer Delegation 規則一樣。
 * Failable Initializer 的override跟其他初始化方法的override規則也一樣，而且子類可override父類的 Failable Initializer 成為 nonfailable Initializer，此時子類要在其中 force-unwrap 父類的 Failable Initializer 结果。
 * 初始化方法用 required 修飾時，表示繼承的所有子類必須實作這個方法
 * 抛出錯誤類型的初始化方法，它不但可以 Failable，而且可以知道初始化失敗的錯誤類型
 */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// Prints "An animal was initialized with a species of Giraffe"

//:Return nil
let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// Prints "The anonymous creature could not be initialized"


//:required
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}
class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}

//:Overriding a Failable Initializer
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
    
    init(name: String  ,aa: String) {
        self.name = name
    }
}
    
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
    
    //注意反過來不行override
//    override init?(name: String ,aa: String) {
//        super.init()
//    }
}

//:Setting a Default Property Value with a Closure or Function
struct Checkerboard {
    let boardColors: [Bool] = {
        //
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard //一定要bool
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
// 輸出 "true"
print(board.squareIsBlackAtRow(9, column: 9))
// 輸出 "false"
 