//
//  ViewController.swift
//  LearningSwift
//
//  Created by Maxim Vasilenko on 24/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Direction {
        case up
        case down
        case left
        case right
    }
    enum HandShape {
        case rock
        case paper
        case scissors
    }
    enum MatchResult {
        case win
        case draw
        case lose
    }
    enum CoinType: Int {
        case nickle = 5
        case quarter = 25
        case penny = 1
        case dime = 10
        
        static let course = 65
        
        func convertToRub() -> Int {
            return CoinType.course * self.rawValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        var location = (x: 0, y: 0)
        let steps: [Direction] = [.up, .up, .left, .down, .left]
        */
        // ( -2, 1)
        /*
        var location = (x: 0, y: 0)
        let steps: [Direction] = [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]
        */
        // ( 1, -2)
        var location = (x: 5, y: 2)
        let steps: [Direction] = [.up, .right, .up, .right, .up, .right, .down, .right]
        // ( 9, 4)
        for iterSteps in steps {
            switch iterSteps {
            case .up:
                location.y += 1
            case .down:
                location.y -= 1
            case .right:
                location.x += 1
            case .left:
                location.x -= 1
            }
        }
        print(location)
        func match(_ firstPlayer: HandShape, _ secondPlayer: HandShape) -> MatchResult {
            switch (firstPlayer, secondPlayer) {
            case ( .rock, .rock):
                return .draw
            case ( .rock, .paper):
                return .lose
            case ( .rock, .scissors):
                return .win
            case ( .paper, .rock):
                return .win
            case ( .paper, .paper):
                return .draw
            case ( .paper, .scissors):
                return .lose
            case ( .scissors, .rock):
                return .lose
            case ( .scissors, .paper):
                return .win
            case ( .scissors, .scissors):
                return .draw
            }
        }
        print(match(.rock, .scissors))
        print(match(.rock, .paper))
        print(match(.scissors, .scissors))
        var moneyArray:[(Int,CoinType)] = [( 10, .penny),
                                           ( 15, .nickle),
                                           (  3, .quarter),
                                           ( 20, .penny),
                                           (  3, .dime),
                                           (  7, .quarter)]
        func countCents(_ coins: [(countCoins: Int, coinsType: CoinType)]) -> Int {
            var resultCountCents = 0
            for coin in coins {
                resultCountCents += coin.countCoins * coin.coinsType.rawValue
                coin.coinsType.convertToRub()
            }
            return resultCountCents
        }
        print(countCents(moneyArray))
    }
}
