//
//  DiscreteWorld.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 27/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

enum Coordinates {
    case x
    case y
    case z
}

protocol DiscreteWorld {
    var width: UInt { get }
    var heigth: UInt { get }
    var depth: UInt { get }
    var length: UInt { get }
    var x0: Int { get }
    var y0: Int { get }
    var z0: Int { get }
    func getCoordinates( index: UInt ) -> ( x: Int, y: Int, z: Int)
    func getIndex( x: Int, y: Int, z: Int ) -> UInt
    func conversIndex( index: UInt) -> UInt
    func conversCoordinate ( coordinate: Int, typeCoordinate: Coordinates) -> Int
    func getFirstNeighbours(index: UInt) -> [UInt]
}
