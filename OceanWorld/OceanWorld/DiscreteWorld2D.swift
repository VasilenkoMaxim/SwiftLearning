//
//  DiscreteWorld2D.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 27/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

class DiscreteWorld2D: DiscreteWorld {
    var width: UInt
    var heigth: UInt
    var depth: UInt = 1
    var length: UInt
    var x0: Int
    var y0: Int
    var z0: Int
    init(horizontalSize: UInt, verticalSize: UInt, referencePoint: ( x0: Int, y0: Int, z0: Int)) {
        self.width = horizontalSize
        self.heigth = verticalSize
        self.length = horizontalSize * verticalSize
        self.x0 = referencePoint.x0
        self.y0 = referencePoint.y0
        self.z0 = referencePoint.z0
    }
    func getCoordinates( index: UInt) -> ( x: Int, y: Int, z: Int) {
        let indexNew: UInt = conversIndex(index: index)
        let x: Int = Int(indexNew) % Int(self.width)
        let y: Int = Int(indexNew) / Int(self.width)
        let z: Int = 0
        return ( x, y, z)
    }
    func getIndex( x: Int, y: Int, z: Int) -> UInt {
        let xNew: Int = conversCoordinate(coordinate: x, typeCoordinate: .x)
        let yNew: Int = conversCoordinate(coordinate: y, typeCoordinate: .y)
        let zNew: Int = conversCoordinate(coordinate: z, typeCoordinate: .z)
        return UInt(Int(self.width * self.heigth)*zNew + Int(self.width)*yNew + xNew)
    }
    func conversIndex(index: UInt) -> UInt {
        if index >= self.length {
            return index % self.length
        } else {
            return index
        }
    }
    func conversCoordinate(coordinate: Int, typeCoordinate: Coordinates) -> Int {
        switch typeCoordinate {
        case .x:
            if coordinate - self.x0 >= Int(self.width) {
                return self.x0 + (coordinate - self.x0) % Int(self.width)
            } else if coordinate < self.x0 {
                return self.x0 + coordinate % Int(self.width) == 0 ? 0 : Int(self.width) + coordinate % Int(self.width)
            } else {
                return coordinate
            }
        case .y:
            if coordinate - self.y0 >= Int(self.heigth) {
                return self.y0 + (coordinate - self.y0) % Int(self.heigth)
            } else if coordinate < self.y0 {
                return self.y0 + coordinate % Int(self.heigth) == 0 ? 0 : Int(self.heigth) + coordinate % Int(self.heigth)
            } else {
                return coordinate
            }
        case .z:
            if coordinate - self.z0 >= Int(self.depth) {
                return self.z0 + (coordinate - self.z0) % Int(self.depth)
            } else if coordinate < self.z0 {
                return self.z0 + coordinate % Int(self.depth) == 0 ? 0 : Int(self.depth) + coordinate % Int(self.depth)
            } else {
                return coordinate
            }
        }
    }
    func getFirstNeighbours(index: UInt) -> [UInt] {
        let firstNeighbours: [(x: Int, y: Int, z: Int)] = [(x: -1, y: -1, z: 0),
                                                           (x: -1, y:  0, z: 0),
                                                           (x: -1, y:  1, z: 0),
                                                           (x:  0, y: -1, z: 0),
                                                           (x:  0, y:  1, z: 0),
                                                           (x:  1, y: -1, z: 0),
                                                           (x:  1, y:  0, z: 0),
                                                           (x:  1, y:  1, z: 0)]
        let coordinate = self.getCoordinates(index: index)
        var indexes: [UInt] = []
        firstNeighbours.forEach { firstNeighbour in indexes.append(self.getIndex(x: coordinate.x + firstNeighbour.x, y: coordinate.y + firstNeighbour.y, z: coordinate.z + firstNeighbour.z))}
        return indexes
    }
}
/*
// Some tests
let myWorld: DiscreteWorld2D = DiscreteWorld2D(horizontalSize: 3, verticalSize: 5, referencePoint: (x0: 0, y0: 0, z0: 0))
print(myWorld.length) // 15
print(myWorld.conversIndex(index: myWorld.length)) // 0
print(myWorld.conversIndex(index: myWorld.length - 1)) // 14
print(myWorld.conversCoordinate(coordinate: 5, typeCoordinate: .z)) // 0
print(myWorld.conversCoordinate(coordinate: -4, typeCoordinate: .z)) // 0
print(myWorld.conversCoordinate(coordinate: 7, typeCoordinate: .y)) // 2
print(myWorld.conversCoordinate(coordinate: -5, typeCoordinate: .y)) // 0
print(myWorld.conversCoordinate(coordinate: 9, typeCoordinate: .x)) // 0
print(myWorld.conversCoordinate(coordinate: -9, typeCoordinate: .x)) // 0
print(myWorld.getCoordinates(index: 10)) // (1, 3, 0)
print(myWorld.getCoordinates(index: 5))  // (2, 1, 0)
print(myWorld.getCoordinates(index: 25)) // (1, 3, 0)
print(myWorld.getIndex(x: 2, y: 3, z: 0)) // 11
print(myWorld.getIndex(x: 3, y: 3, z: 0)) // 9
print(myWorld.getIndex(x: 5, y: 6, z: 10)) // 5
print(myWorld.getIndex(x: -3, y: -5, z: -1)) // 0
print(myWorld.getFirstNeighbours(index: 13)) // [9, 12, 0, 10, 1, 11, 14, 2]
*/

