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
    override init(horizontalSize: UInt, verticalSize: UInt, referencePoint: (x0: Int, y0: Int, z0: Int)) {
        self.animalsArray = Array(repeating: Animalable?.none, count: Int(horizontalSize * verticalSize))
        super.init(horizontalSize: horizontalSize, verticalSize: verticalSize, referencePoint: referencePoint)
    }
    func initAnimals( orcaPercent: Double, tuxPercent: Double) {
        let orcaCount = Int ( Double(self.length) * orcaPercent / 100.0)
        let tuxCount = Int ( Double(self.length) * tuxPercent / 100.0)
        var orcaArray: [Orca] = []; for _ in 1...orcaCount { orcaArray.append(Orca()) }
        var tuxArray: [Tux] = []; for _ in 1...tuxCount { tuxArray.append(Tux()) }
        let emptySiteArray = Array(repeating: Animalable?.none, count: Int(self.length) - orcaCount - tuxCount) // error if self.length < orcaCount + tuxCount
        self.animalsArray.replaceSubrange(0..<orcaCount, with: orcaArray)
        self.animalsArray.replaceSubrange(orcaCount..<orcaCount+tuxCount, with: tuxArray)
        self.animalsArray.replaceSubrange(orcaCount+tuxCount..<Int(self.length), with: emptySiteArray)
        self.animalsArray.shuffle()
        for i in 0...self.animalsArray.count-1 { if self.animalsArray[i] != nil { self.roundQueue.append(UInt(i)) }}
    }
    func stepInRound() -> [UInt] {
        if self.roundQueue.isEmpty {
            for i in 0...self.animalsArray.count-1 { if self.animalsArray[i] != nil { self.roundQueue.append(UInt(i)) }}
            self.time += 1
            if self.roundQueue.isEmpty {
                return []
            }
        }
        let changedIndexes: [UInt] = self.animalsArray[Int(self.roundQueue[0])]?.doSomething(myWorld: self, myIndex: self.roundQueue[0]) ?? []
        if changedIndexes.isEmpty {
            self.roundQueue.remove(at: 0)
        } else {
            changedIndexes.forEach { arrayElement in self.roundQueue.removeAll(where: { $0 == arrayElement } ) }
        }
        return changedIndexes
    }
}
