//
//  DiscreteWorld.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 27/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

struct Point {
    var x: Int
    var y: Int
    var z: Int
    static func +( first: Point, second: Point) -> Point {
        return Point( x: first.x + second.x, y: first.y + second.y, z: first.z + second.z)
    }
}

protocol DiscreteWorld {
    var width: UInt { get }
    var heigth: UInt { get }
    var depth: UInt { get }
    var length: UInt { get }
    var startPoint: Point { get }
    func getCoordinate( index: UInt ) -> Point
    func getIndex( point: Point ) -> UInt
    func conversIndex( index: UInt) -> UInt
    func conversCoordinate( point: Point ) -> Point
    func getFirstNeighbours( index: UInt) -> [UInt]
}
