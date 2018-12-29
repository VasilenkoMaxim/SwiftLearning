var arr1: [Int?] = Array(repeating: Int?.none, count: 10)
var arr2: [Int?] = Array(repeating: 1, count: 3)
var arr3: [Int?] = Array(repeating: 2, count: 4)
arr1.append(contentsOf: arr2)

arr1[0..<3] = arr2[0..<3]
arr1[3..<7] = arr3[0..<4]
arr1
var arr4: [Int] = []
arr4.randomElement()
var numbers = [5, 6, 7, 8, 9, 10, 11]
numbers.removeAll(where: { $0 == 1 })
numbers
/*
var arr4 = 1..<4

func getCoordinates(index: UInt, length: UInt, width: UInt) -> (x: Int, y: Int, z: Int ) {
    var indexNew: UInt
    if index >= length {
        indexNew = index % length
    } else {
        indexNew = index
    }
    let x: Int = Int(indexNew) % Int(width)
    let y: Int = Int(indexNew) / Int(width)
    let z: Int = 0
    return ( x, y, z)
}
var index: UInt = 14
var length: UInt = 15
var width: UInt = 3
print(getCoordinates(index: index, length: length, width: width))
*/



