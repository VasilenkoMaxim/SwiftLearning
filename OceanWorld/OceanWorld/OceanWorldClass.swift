//
//  WorldClass.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation


class OceanWorld: DiscreteWorld2D {
    var animalsArray: Array<Animalable?>
    var time: UInt = 1 // one time - one round
    var roundQueue: [UInt] = []
    
    override init(horizontalSize: UInt, verticalSize: UInt, startPoint: Point) {
        self.animalsArray = Array(repeating: Animalable?.none, count: Int(horizontalSize * verticalSize))
        super.init(horizontalSize: horizontalSize, verticalSize: verticalSize, startPoint: startPoint)
    }
    
    func initAnimals( orcaPercent: Double, tuxPercent: Double) {
        guard orcaPercent + tuxPercent < 100.0 else {
            print("ololo")
            return
        }
        let orcaCount = Int( (Double(self.length) * orcaPercent / 100.0).rounded() )
        let tuxCount = Int( (Double(self.length) * tuxPercent / 100.0).rounded() )
        var orcaArray: [Orca] = [];
        for _ in 0..<orcaCount {
            orcaArray.append(Orca())
        }
        var tuxArray: [Tux] = [];
        for _ in 0..<tuxCount {
            tuxArray.append(Tux())
        }
        let emptySiteArray = Array(repeating: Animalable?.none, count: Int(self.length) - orcaCount - tuxCount) // error if self.length < orcaCount + tuxCount
        self.animalsArray.replaceSubrange(0..<orcaCount, with: orcaArray)
        self.animalsArray.replaceSubrange(orcaCount..<orcaCount+tuxCount, with: tuxArray)
        self.animalsArray.replaceSubrange(orcaCount+tuxCount..<Int(self.length), with: emptySiteArray)
        self.animalsArray.shuffle()
        self.roundQueue = []
        for i in 0..<self.animalsArray.count where self.animalsArray[i] != nil {
            self.roundQueue.append(UInt(i))
        }
    }
    
    func stepInRound() -> [UInt]? {
        if self.roundQueue.isEmpty {
            self.time += 1
            for i in 0..<self.animalsArray.count where self.animalsArray[i] != nil {
                self.roundQueue.append(UInt(i))
            }
            if self.roundQueue.isEmpty {
                return nil
            }
        }
        if let changedIndexes: [UInt] = self.animalsArray[Int(self.roundQueue[0])]?.doSomething(myWorld: self, myIndex: self.roundQueue[0]) {
            self.roundQueue.remove(at: 0)
            changedIndexes.forEach { arrayElement in self.roundQueue.removeAll(where: { $0 == arrayElement } ) }
            return changedIndexes
        }
        self.roundQueue.remove(at: 0)
        return nil
    }
    
}
