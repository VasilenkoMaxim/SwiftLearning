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
    
    func getCoordinate( index: UInt) -> Point? {
        if self.length == 0 {
            return nil
        } else {
            let indexNew: UInt = self.conversIndex(index: index) ?? 0
            let point = Point(x: Int(indexNew) % Int(self.width) + self.startPoint.x,
                              y: Int(indexNew) / Int(self.width) + self.startPoint.y,
                              z: self.startPoint.z)
            return point
        }
    }
    	
    func getIndex( point: Point) -> UInt? {
        if self.length == 0 {
            return nil
        } else {
            var newPoint: Point = self.conversCoordinate( point: point) ?? self.startPoint
            newPoint = newPoint - self.startPoint
            return UInt(Int(self.width * self.heigth)*newPoint.z + Int(self.width)*newPoint.y + newPoint.x)
        }
    }
    
    private func conversIndex(index: UInt) -> UInt? {
        if self.length == 0 {
            return nil
        } else {
            return index % self.length
        }
    }
    
    private func conversCoordinate(point: Point) -> Point? {
        if self.length == 0 {
            return nil
        } else {
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
    }
    
    func getFirstNeighbours(index: UInt) -> [UInt]? {
        let firstNeighbours: [Point] = [Point(x: -1, y: -1, z: 0),
                                        Point(x: -1, y:  0, z: 0),
                                        Point(x: -1, y:  1, z: 0),
                                        Point(x:  0, y: -1, z: 0),
                                        Point(x:  0, y:  1, z: 0),
                                        Point(x:  1, y: -1, z: 0),
                                        Point(x:  1, y:  0, z: 0),
                                        Point(x:  1, y:  1, z: 0)]
        if let coordinate = self.getCoordinate(index: index) {
            var indexes: [UInt] = []
            firstNeighbours.forEach {
                firstNeighbour in
                if let newIndex = self.getIndex( point: coordinate + firstNeighbour) {
                    if index != newIndex {
                        indexes.append(newIndex)
                    }
                }
            }
            return Array(Set(indexes))
        } else {
            return nil
        }
    }

}
