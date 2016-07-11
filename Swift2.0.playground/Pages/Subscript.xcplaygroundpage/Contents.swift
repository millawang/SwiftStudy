//: [Previous](@previous)
/*:
 ### Subscripts
* 使用索引來對一個物件快速存取值的方法
* subscript)使用運算子 "[]" 來操作一個實體
* 可以使用在類別、結構以及列舉上
* 宣告方式類似於屬性的 getter 以及 setter 方法
*/
class Student{
    var scores:[Int] = Array(count:5,repeatedValue:0)
    subscript(index:Int) -> Int{
        get{
            return scores[index];
        }
        set{
            scores[index] = newValue
        }
    }
    
    subscript(indexs:Int...) -> [Int]{
        get{
            var values:[Int] = Array()
            for index in indexs {
                values.append(scores[index])
            }
            return values
        }
        set{
            var i = 0
            for index in indexs{
                scores[index] = newValue[i++]
            }
        }
    }
}
var a = Student()
a[0] = 1
a[1] = 2
a[1,2,3] = [5,6,7]
//print("a[0]:\(a[0]),a[1]:\(a[1])”)

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + columns] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)

//example
struct FactorialGenerator
{
    subscript(n: Int) -> Int
    {
        var result = 1
        
        if n > 0
        {
            for value in 1...n
            {
                result *= value
            }
        }
        
        return result
    }
}
let factorial = FactorialGenerator()
print("Five factorial is equal to \(factorial[5]).")


//: [Next](@next)
