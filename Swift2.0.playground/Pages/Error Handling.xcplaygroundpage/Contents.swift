//: [Previous](@previous)
//: ### Error Handling

enum VendingMachineError: ErrorType {
    case InvalidSelection  //無效的選擇
    case InsufficientFunds(coinsNeeded: Int)  //金額不足
    case OutOfStock //缺貨
}

//拋出還需要5個金幣的錯誤訊息
throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

//  without return
func canThrowErrors() throws {
    //body
    
}
//  return
func canThrowErrors() throws -> String {
    //body
    return "hello world"
}


struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    //  商品清單
    var inventory = ["Candy Bar": Item(price: 12, count: 5),
                     "Chips": Item(price: 10, count: 4),
                     "Pretzel": Item(price: 15, count: 8)]
    
    var coinDeposited = 0
    
    private func dispenceSnack(snack: String) {
        print("dispence \(snack)")     //  打印分发了什么小吃
    }
   
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection      //  選擇的物品不存在
        }
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock           //  缺貨
        }
        guard item.price <= coinDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinDeposited)     //  錢不足
        }
        //  消費完畢，自動販賣機發生改變
        coinDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenceSnack(name)
    }
}
//------- Sample 2
let favoriteSnacks = ["Jack": "Chips",
                      "Tom": "Milk",
                      "Rose": "Meat"]

func buyFavoriteSnacks(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    //  throwing 函數必須使用 try 來獲取拋出的錯誤
    //  僅是傳遞錯誤
    try vendingMachine.vend(itemNamed: snackName)
}
//:Do Catch 處理錯誤

//: ![The real head of the household?](errorHandling.png)

var vendingMachine = VendingMachine()
vendingMachine.coinDeposited = 8
do {
    try buyFavoriteSnacks("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

/*
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
 */
//let photo = try! loadImage("./Resources/John Appleseed.jpg")
//:defer
struct HandleFile {
    func readline() throws -> String {
        
        return "hello world"
    }
}

func exists(file: String) -> Bool {
    
    return true
}

func open(file: String) -> HandleFile {
    let file = HandleFile()
    return file
}

func close(file: HandleFile) {
}
func processFile(fileName: String) throws {
    if exists(fileName) {
        let file = open(fileName)
        defer {
            close(file)
        }
        while let line = try? file.readline() {
            
            print(line)
        }
    }
}
