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
    var startPoint: Point
        
    init(horizontalSize: UInt, verticalSize: UInt, startPoint: Point) {
        self.width = horizontalSize
        self.heigth = verticalSize
        self.length = horizontalSize * verticalSize
        self.startPoint = startPoint
    }
    
    func getCoordinate( index: UInt) -> Point {
        let indexNew: UInt = self.conversIndex(index: index)
        let point = Point(x: Int(indexNew) % Int(self.width),
                          y: Int(indexNew) / Int(self.width),
                          z: 0)
        return point
    }
    	
    func getIndex( point: Point) -> UInt {
        let newPoint = self.conversCoordinate( point: point)
        return UInt(Int(self.width * self.heigth)*newPoint.z + Int(self.width)*newPoint.y + newPoint.x)
    }
    
    func conversIndex(index: UInt) -> UInt {
        return index % self.length
    }
    
    func conversCoordinate(point: Point) -> Point {
        var conversPoint = Point( x: 0, y: 0, z: 0)
        if point.x - self.startPoint.x >= Int(self.width) {
            conversPoint.x = self.startPoint.x + (point.x - self.startPoint.x) % Int(self.width)
        } else if point.x < self.startPoint.x {
            conversPoint.x = (self.startPoint.x + Int(self.width) - 1) - (self.startPoint.x - point.x - 1) % Int(self.width)
        } else {
            conversPoint.x = point.x
        }
        if point.y - self.startPoint.y >= Int(self.heigth) {
            conversPoint.y = self.startPoint.y + (point.y - self.startPoint.y) % Int(self.heigth)
        } else if point.y < self.startPoint.y {
            conversPoint.y = (self.startPoint.y + Int(self.heigth) - 1) - (self.startPoint.y - point.y - 1) % Int(self.heigth)
        }else{
            conversPoint.y = point.y
        }
        if point.z - self.startPoint.z >= Int(self.depth) {
            conversPoint.z = self.startPoint.z + (point.z - self.startPoint.z) % Int(self.depth)
        } else if point.z < self.startPoint.z {
            conversPoint.z = (self.startPoint.z + Int(self.depth) - 1) - (self.startPoint.z - point.z - 1) % Int(self.depth)
        }else{
            conversPoint.z = point.z
        }
        return conversPoint
    }
    func getFirstNeighbours(index: UInt) -> [UInt] {
        let firstNeighbours: [Point] = [Point(x: -1, y: -1, z: 0),
                                        Point(x: -1, y:  0, z: 0),
                                        Point(x: -1, y:  1, z: 0),
                                        Point(x:  0, y: -1, z: 0),
                                        Point(x:  0, y:  1, z: 0),
                                        Point(x:  1, y: -1, z: 0),
                                        Point(x:  1, y:  0, z: 0),
                                        Point(x:  1, y:  1, z: 0)]
        let coordinate = self.getCoordinate(index: index)
        var indexes: [UInt] = []
        firstNeighbours.forEach { firstNeighbour in indexes.append(self.getIndex( point: coordinate + firstNeighbour)) }
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

