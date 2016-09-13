//: [Previous](@previous)
//: ### Access Control


public class SomePublicClass {}
internal class SomeInternalClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
private func somePrivateFunction() {}


class AnotherInternalClass {}              //implicitly　internal
var AnotherInternalConstant = 0            //implicitly　internal

//: Custom Types
public class AnotherPublicClass {          // explicitly public
    public var somePublicProperty = 0      // explicitly public
    var someInternalProperty = 0           // implicitly internal
    private func somePrivateMethod() {}    // explicitly private
}

class YetAnotherInternalClass {            // implicitly internal
    var someInternalProperty = 0           // implicitly internal
    private func somePrivateMethod() {}    // explicitly private
}

private class AnotherPrivateClass {        // explicitly private
    var somePrivateProperty = 0            // implicitly private
    func somePrivateMethod() {}            // implicitly private
}

/*: Tuple types do not have a standalone definition in the way that classes, structures, enumerations, and functions do. A tuple type’s access level is deduced automatically when the tuple type is used, and cannot be specified explicitly.*/
private var privateMsg = "Not Found!"
internal var internalCode = 404
let responseTuple = (internalCode, privateMsg) //private

//:Function
// 層級是由此函式的傳入參數及回傳值所推斷出來。如果依據傳入參數以及回傳值所得出的函
// 式存有出入，那麼就要明確地指定此函式的層級
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass(), SomePrivateClass())
}

//: Enum
public enum CompassPoint {
    case North
    case South
    case East
    case West
}

//: Subclassing
// 子類別的存取層級不可以高於所繼承的父類別。例如，一個繼承了 internal 層級類別的子類別，其層級就不可以是 public
// 。在不違背這個規則的前提下，開發者可以任意覆寫內部成員為不同的層級
public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}  //override someMethod private to internal
}

internal class AnotherB: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

//: Constants, Variables, Properties, and Subscripts
//Constants, Variables, Properties不可以擁有比它們的型別更高的存取層級。
//public class SomeClass {
//    public var publicInstance = SomePrivateClass()
//}

// 如果一個常數、變數、屬性或下標腳本的存取層級為 private，那麼宣告它們的時候必須顯式地指定為 private：
private var privateInstance = SomePrivateClass() //explicitly private


// 常數、變數、屬性以及下標腳本的 getter 與 setter 方法的access control，繼承自它們所屬成員的access control。
// Setter 的access control可以低於相應的 getter，以控制變數、屬性或下標腳本的讀寫權限。你可以在 var 或 subscript 關鍵字之前，使用
// private(set) 和 internal(set) 這個語法來指定較低的access control
//
// 下面這個例子定義了一個名為 TrackedString 的結構，它可以用來計算 value 屬性被修改的次數。這個結構被隱式地推斷
// 為 internal 層級，因此它內部的成員也是 internal 層級。但這裡使用 private(set) 關鍵字來顯式地指定這個用來記
// 錄被修改次數的屬性，其存取只能由同結構的內部成員做修改。因為此屬性默認的 getter 未被修改，所以 getter 的層級會
// 被隱式地推斷為 internal，因此對於內部成員而言，這個屬性是讀/寫，但對非此結構的外部程式碼來說，這個屬性是唯讀：
struct TrackedString { //internal
    private(set) var numberOfEdits = 0
    var value: String = "" {  //internal
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
"The number of edits is \(stringToEdit.numberOfEdits)"

//: Initializers
// 我們也可以替自定義的建構器指定層級，但是不可以高於它所屬類別的層級，如果此建構器
// 必須被使用的(例如唯一的建構器)，那麼此建構器的層級必須跟所屬類別的層級相同
public class PublicClass {
    public init() {}
}

//: Protocol
private protocol PrivateProtocol {
    var varInPrivateProtocol: Int { get }
}

protocol InternalProtocol {
    var varInInternalProtocol: Int { get }
}

//private protocol TestInternalProtocol:PrivateProtocol{
//    var varInPrivateProtocol: Int { get }
//}

//When you write or extend a type to conform to a protocol, you must ensure that the type’s implementation of each protocol requirement has at least the same access level as the type’s conformance to that protocol.
class AlsoInternalClass: PrivateProtocol, InternalProtocol {
    private var varInPrivateProtocol: Int
    internal var varInInternalProtocol: Int
    init( priv: Int, inte: Int) {
        self.varInPrivateProtocol = priv
        self.varInInternalProtocol = inte
    }
}


//: Extensions
// 對類別、結構以及列舉做的擴展，會跟所擴展的對象擁有相同的層級，例如你Extensions了一個 public 層級的型別，那麼任何
// 對此型別的Extensions都會擁有default的 internal 層級
//
// 除此之外，你可以宣告一個擴展的層級(例如 private extension)，以此讓所有在此擴展中的成員都擁有相同的
// default層級。這個default層級可被各別成員所指定的存取層級覆寫
public struct Test { }
extension Test {
    // 1. This will be default to internal because Test is public?
    var prop: String { return "" }
}

public extension Test {
    // 2. This will have access level of public because extension is marked public?
    var prop2: String { return ""
}

// Adding Protocol Conformance with an Extension
/* You cannot provide an explicit access level modifier for an extension if you are using that extension to add protocol conformance. Instead, the protocol’s own access level is used to provide the default access level for each protocol requirement implementation within the extension.
如果你正使用一個擴展來遵循某個協定，那麼你不可以指定層級給這個擴展。取而代之的是，這個協定本身的層級將變成default的層級，指定給擴展中每個滿足協定要求的實作*/

//:Generic
//　The access level for a generic type or generic function is the minimum of the access level of the generic type or function itself and the access level of any type constraints on its type parameters.


//:Type Aliases
typealias InternalDouble = Double

// 相等或更低的層級
internal typealias AnotherInternalDouble = InternalDouble
private typealias PrivateDouble = InternalDouble

// 不可以宣告為更高的層級，此行無法編譯
//public typealias PublicDouble = InternalDouble

//: [Next](@next)
