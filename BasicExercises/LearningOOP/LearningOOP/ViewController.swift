//
//  ViewController.swift
//  LearningOOP
//
//  Created by Maxim Vasilenko on 25/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import UIKit

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
    var position: ( String, UInt)?
    init ( chessFigure: ChessFigures, color: Color) {
        self.chessFigure = chessFigure
        self.color = color
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var whitePawn = Chessmen(chessFigure: .pawn, color: .white)
        whitePawn.chessFigure = .queen
        print(whitePawn.chessFigure)
    }


}

