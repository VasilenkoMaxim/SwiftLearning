enum Color: String {
    case black = "Черный"
    case white = "Белый"
}

enum ChessFigures: String {
    case pawn   = "Пешка"
    case bishop = "Слон"
    case knight = "Конь"
    case rook   = "Ладья"
    case queen  = "Ферзь"
    case king   = "Король"
}

struct Chessmen {
    var chessFigure: ChessFigures
    var color: Color
    var position: (char: String, num: UInt)?
    init ( chessFigure: ChessFigures, color: Color) {
        self.chessFigure = chessFigure
        self.color = color
    }
    mutating func setCoordinates(char: String, num: UInt){
        self.position = ( char: char, num: num)
    }
    mutating func kill() {
        self.position = nil
    }
}

//var whiteBishop = Chessmen(chessFigure: .bishop, color: .white)
//whiteBishop.setCoordinates(char: "a", num: 1)
//print(whiteBishop.position)
//whiteBishop.kill()
//print(whiteBishop.position)

for i in Array(0..<8).reversed() {
    print(i)
}
