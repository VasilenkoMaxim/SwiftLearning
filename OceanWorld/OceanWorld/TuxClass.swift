//
//  TuxClass.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

class Tux: Animalable {
    var name: String? = "tux"
    let stepsToReproduce = Constants.stepsToReproduceTux
    var myCountSteps: UInt = 0
    init() {
    }
    
    func doSomething(myWorld: OceanWorld, myIndex: UInt) -> [UInt]? {
        self.myCountSteps += 1
        if self.myCountSteps % self.stepsToReproduce == 0 {
            return self.reproduce(myWorld: myWorld, myIndex: myIndex)
        }
        else {
            return self.move(myWorld: myWorld, myIndex: myIndex)
        }
    }
    
    func move( myWorld: OceanWorld, myIndex: UInt) -> [UInt]? {
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
            myWorld.animalsArray[Int(newIndex)] = self
            myWorld.animalsArray[Int(myIndex)] = nil
            return [ myIndex, newIndex]
        } else {
            return nil
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
            myWorld.animalsArray[Int(newIndex)] = Tux()
            return [newIndex]
        } else {
            return nil
        }
    }
    
    func death(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        myWorld.animalsArray[Int(myIndex)] = nil
        return [myIndex]
    }
}
