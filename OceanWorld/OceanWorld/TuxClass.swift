//
//  TuxClass.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

class Tux: Animalable {
    let stepsToReproduce = Constants.stepsToReproduceTux
    
    init() {
    }
    
    func doSomething(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        if myWorld.time % self.stepsToReproduce == 0 {
            return self.reproduce(myWorld: myWorld, myIndex: myIndex)
        }
        else {
            return self.move(myWorld: myWorld, myIndex: myIndex)
        }
    }
    
    func move( myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        var neighbours = myWorld.getFirstNeighbours(index: myIndex)
        for i in 1...8 {
            if myWorld.animalsArray[Int(neighbours[8-i])] != nil {
                neighbours.remove(at: 8-i)
            }
        }
        let newIndex: UInt = neighbours.randomElement() ?? myIndex
        if newIndex == myIndex {
            return []
        }
        else
        {
            myWorld.animalsArray[Int(newIndex)] = self
            myWorld.animalsArray[Int(myIndex)] = nil
            return [ myIndex, newIndex]
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
            return []
        }
        else
        {
            myWorld.animalsArray[Int(newIndex)] = Tux()
            return [newIndex]
        }
    }
    
    func death(myWorld: OceanWorld, myIndex: UInt) -> [UInt] {
        myWorld.animalsArray[Int(myIndex)] = nil
        return [myIndex]
    }
}
