//
//  AnimalablePrototype.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import Foundation

protocol Animalable {
    var stepsToReproduce: UInt { get }
    func doSomething(myWorld: OceanWorld, myIndex: UInt) -> [UInt]
    func move(myWorld: OceanWorld, myIndex: UInt) -> [UInt]
    func death(myWorld: OceanWorld, myIndex: UInt) -> [UInt]
    func reproduce(myWorld: OceanWorld, myIndex: UInt) -> [UInt]
}
