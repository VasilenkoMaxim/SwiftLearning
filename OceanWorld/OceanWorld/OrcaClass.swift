//
//  OrcaClass.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

class Orca: Animalable {
    var name: String? = "orca"
    let stepsToReproduce: UInt = Constants.stepsToReproduceOrca
    var stepsToDeathNoEat: UInt = Constants.stepsToDeathOrcaNoEat
    var myCountSteps: UInt = 0
    
    init() {
    }
    
    func doSomething(myWorld: OceanWorld, myIndex: UInt) -> [UInt]? {
        self.myCountSteps += 1
        self.stepsToDeathNoEat -= 1
        if self.myCountSteps % self.stepsToReproduce == 0 {
            return self.reproduce(myWorld: myWorld, myIndex: myIndex)
        }
        else {
            return self.move(myWorld: myWorld, myIndex: myIndex)
        }
    }
    
    func move( myWorld: OceanWorld, myIndex: UInt) -> [UInt]? {
        var neighbours: [UInt] = myWorld.getFirstNeighbours(index: myIndex) ?? []
        var neighboursTux: [UInt] = []
        var neighboursEmptySite: [UInt] = []
        if !neighbours.isEmpty {
            for i in Array(0..<neighbours.count) {
                if myWorld.animalsArray[Int(neighbours[i])] is Tux {
                    neighboursTux.append(neighbours[i])
                }
                if myWorld.animalsArray[Int(neighbours[i])] == nil {
                    neighboursEmptySite.append(neighbours[i])
                }
            }
        } else {
            return nil
        }
        if let newIndex: UInt = neighboursTux.randomElement() ?? neighboursEmptySite.randomElement() {
            if myWorld.animalsArray[Int(newIndex)] is Tux {
                self.stepsToDeathNoEat = Constants.stepsToDeathOrcaNoEat
            } else {
                if self.stepsToDeathNoEat == 0 {
                    return self.death(myWorld: myWorld, myIndex: myIndex)
                }
            }
            myWorld.animalsArray[Int(newIndex)] = self
            myWorld.animalsArray[Int(myIndex)] = nil
            return [ myIndex, newIndex]
        } else {
            if self.stepsToDeathNoEat == 0 {
                return self.death(myWorld: myWorld, myIndex: myIndex)
            } else {
                return nil
            }
        }
    }
    
    func reproduce(myWorld: OceanWorld, myIndex: UInt) -> [UInt]? {
        var neighbours: [UInt] = myWorld.getFirstNeighbours(index: myIndex) ?? []
        if !neighbours.isEmpty {
            for i in Array(0..<neighbours.count).reversed() {
                if myWorld.animalsArray[Int(neighbours[i])] != nil {
                    neighbours.remove(at: i)
                }
            }
        } else {
            return nil
        }
        if let newIndex: UInt = neighbours.randomElement() {
            myWorld.animalsArray[Int(newIndex)] = Orca()
            if self.stepsToDeathNoEat == 0 {
                return  self.death(myWorld: myWorld, myIndex: myIndex) + [newIndex]
            } else {
                return [newIndex]
            }
        } else {
            if self.stepsToDeathNoEat == 0 {
                return self.death(myWorld: myWorld, myIndex: myIndex)
            } else {
                return nil
            }
        }
    }
    
    func death(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        myWorld.animalsArray[Int(myIndex)] = nil
        return [myIndex]
    }
}
