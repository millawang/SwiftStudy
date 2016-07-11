/*:
 ### Practice playground
Practice playgroun
 ## Practice playground
 # Practice playground
 * Practice playground 1
 * Practice playground 2
 */
 
import UIKit
import XCPlayground

//:Miffy 插圖
//: ![The real head of the household?](miffy2.jpg)

var str = "Hello, playground"
/*:
 ## Show LiveView
 * View > Assistant Editor > Show Assistant Editor.
 */
let frame = CGRect(x:0,y:0, width:150,height: 150)
let aquaColor = [#Color(colorLiteralRed: 0.2856909930706024, green: 0, blue: 0.9589199423789978, alpha: 1)#]
XCPlaygroundPage.currentPage.captureValue(aquaColor, withIdentifier: "紫色")
XCPlaygroundPage.currentPage.captureValue(frame, withIdentifier: "View frame")


/*:
 ## Viewing the Console
 * View > Debug Area > Show Debug Area
 */
/*:
 ## Showing a Results View (如下面範例)
 * Editor > Show Result for Current Line.
 * Editor > Hide Result for Current Line.
 * Resizing a Results View (拖曳邊框)
 * 修改 Results View style (按右鍵 or Editor > Result Display Mode
 */
var j = 2
for var i = 0;i < 5; ++i{
    j += j * i
}


/*:
 ## Adding Resources to a Playground
 * 在Resources目錄按右鍵 or File > Add Files to "Resources" or "+" button (新增已存在檔案 or new)
 */

/*:
 ## Adding an Image Literal and Its Image File
 * Editor > Insert Image Literal.
 */
let imageView = UIImageView(image:[#Image(imageLiteral: "miffy2.jpg")#])

/*:
 ## Adding a File Literal and Its File
 * Editor > Insert File Literal.
 */
let liFile = [#FileReference(fileReferenceLiteral: "Swift_2_Collection_Type.pptx")#]

/*:
 ## Adding Color Literals
 * Choose Editor > Insert Color Literal.
 */
let tintColorImageView = UIImageView(image:[#Image(imageLiteral: "rev_close.png")#]  .imageWithRenderingMode(.AlwaysTemplate))
tintColorImageView.tintColor = [#Color(colorLiteralRed: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 1)#]


/*:
 * [Next](@next)
 * [Previous](@previous)
 * [MainPage](First%20Page)
 */
