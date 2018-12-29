//
//  OrcaClass.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

class Orca: Animalable {
    let stepsToReproduce = Constants.stepsToReproduceOrca
    var stepsToDeathNoEat = Constants.stepsToDeathOrcaNoEat
    init() {
    }
    func doSomething(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        self.stepsToDeathNoEat -= 1
        if myWorld.time % self.stepsToReproduce == 0 {
            return self.reproduce(myWorld: myWorld, myIndex: myIndex)
        }
        else {
            return self.move(myWorld: myWorld, myIndex: myIndex)
        }
    }
    func move( myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        var neighbours = myWorld.getFirstNeighbours(index: myIndex)
        var neighboursTux: [UInt] = []
        var neighboursEmptySite: [UInt] = []
        for i in 1...8 {
            if myWorld.animalsArray[Int(neighbours[8-i])] is Tux {
                neighboursTux.append(neighbours[8-i])
            }
            if myWorld.animalsArray[Int(neighbours[8-i])] == nil {
                neighboursEmptySite.append(neighbours[8-i])
            }
        }
        let newIndex: UInt = neighboursTux.randomElement() ?? (neighboursEmptySite.randomElement() ?? myIndex)
        
        if newIndex == myIndex {
            if self.stepsToDeathNoEat == 0 {
                return self.death(myWorld: myWorld, myIndex: myIndex)
            } else {
                return []
            }
        }
        else
        {
            if myWorld.animalsArray[Int(newIndex)] is Tux {
                self.stepsToDeathNoEat = Constants.stepsToDeathOrcaNoEat
                myWorld.animalsArray[Int(newIndex)] = self
                myWorld.animalsArray[Int(myIndex)] = nil
                return [ myIndex, newIndex]
            } else {
                if self.stepsToDeathNoEat == 0 {
                    return self.death(myWorld: myWorld, myIndex: myIndex)
                } else {
                    myWorld.animalsArray[Int(newIndex)] = self
                    myWorld.animalsArray[Int(myIndex)] = nil
                    return [ myIndex, newIndex]
                }
            }
        }
    }
    func reproduce(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        var neighbours = myWorld.getFirstNeighbours(index: myIndex)
        for i in 1...8 {
            if myWorld.animalsArray[Int(neighbours[8-i])] != nil {
                neighbours.remove(at: 8-i)
            }
        }
        let newIndex: UInt = neighbours.randomElement() ?? myIndex
        if newIndex == myIndex {
            if self.stepsToDeathNoEat == 0 {
                return self.death(myWorld: myWorld, myIndex: myIndex)
            } else {
                return []
            }
        }
        else
        {
            myWorld.animalsArray[Int(newIndex)] = Orca()
            if self.stepsToDeathNoEat == 0 {
                _ = self.death(myWorld: myWorld, myIndex: myIndex)
                return  [myIndex, newIndex]
            } else {
                return [newIndex]
            }
        }
    }
    func death(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        myWorld.animalsArray[Int(myIndex)] = nil
        return [myIndex]
    }
}
