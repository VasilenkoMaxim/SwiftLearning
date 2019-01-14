//
//  Unit_DiscreteWorld2DTest.swift
//  OceanWorldTests
//
//  Created by Maxim Vasilenko on 14/01/2019.
//  Copyright © 2019 Maxim Vasilenko. All rights reserved.
//

import XCTest
@testable import OceanWorld

class DiscreteWorld2D_mock: DiscreteWorld2D {

}

class Unit_DiscreteWorld2DTest: XCTestCase {
    
    func testGetCoordinate() {
        var discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        var point = discreteWorld2D.getCoordinate(index: 0)
        XCTAssert( point! == Point(x: -1, y: 3, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 10)
        XCTAssert( point! == Point(x: 0, y: 6, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 15)
        XCTAssert( point! == Point(x: -1, y: 3, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 20)
        XCTAssert( point! == Point(x: 1, y: 4, z: 10) )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 0, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 10)
        XCTAssert( point == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 0, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 48)
        XCTAssert( point == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 0, verticalSize: 0, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 174)
        XCTAssert( point == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 2, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 4)
        XCTAssert( point! == Point(x: -1, y: 5, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 12)
        XCTAssert( point! == Point(x: -1, y: 4, z: 10) )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 1, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 10)
        XCTAssert( point! == Point(x: -1, y: 3, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 7)
        XCTAssert( point! == Point(x: -1, y: 5, z: 10) )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 2, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 10)
        XCTAssert( point! == Point(x: 0, y: 4, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 2)
        XCTAssert( point! == Point(x: 1, y: 3, z: 10) )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 1, startPoint: Point(x: -1, y: 3, z: 10))
        point = discreteWorld2D.getCoordinate(index: 1)
        XCTAssert( point! == Point(x: 0, y: 3, z: 10) )
        point = discreteWorld2D.getCoordinate(index: 8)
        XCTAssert( point! == Point(x: 1, y: 3, z: 10) )
    }
    
    func testGetIndex() {
        var discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        var index = discreteWorld2D.getIndex(point: Point(x: -1, y: 3, z: 10))
        XCTAssert( index == 0 )
        index = discreteWorld2D.getIndex(point: Point(x: 0, y: 5, z: 10))
        XCTAssert( index == 7 )
        index = discreteWorld2D.getIndex(point: Point(x: 2, y: 6, z: 10))
        XCTAssert( index == 9 )
        index = discreteWorld2D.getIndex(point: Point(x: -3, y: 4, z: 10))
        XCTAssert( index == 4 )
        index = discreteWorld2D.getIndex(point: Point(x: -1, y: 12, z: 10))
        XCTAssert( index == 12 )
        index = discreteWorld2D.getIndex(point: Point(x: 1, y: 0, z: 10))
        XCTAssert( index == 8 )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 0, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        index = discreteWorld2D.getIndex(point: Point(x: 2, y: 6, z: 10))
        XCTAssert( index == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 0, startPoint: Point(x: -1, y: 3, z: 10))
        index = discreteWorld2D.getIndex(point: Point(x: 2, y: 6, z: 10))
        XCTAssert( index == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 0, verticalSize: 0, startPoint: Point(x: -1, y: 3, z: 10))
        index = discreteWorld2D.getIndex(point: Point(x: 2, y: 6, z: 10))
        XCTAssert( index == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 2, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        var points: [Point] = [Point(x: -1, y:  5, z: 10),
                               Point(x: -3, y:  7, z: 1),
                               Point(x:  0, y: -1, z: 13),
                               Point(x:  1, y:  3, z: 4),
                               Point(x:  0, y: 12, z: 7)]
        var indexes: [UInt] = [4, 8, 3, 0, 9]
        for i in 0..<points.count {
            let index = discreteWorld2D.getIndex(point: points[i])
            XCTAssert( index! == indexes[i] )
        }
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 1, verticalSize: 5, startPoint: Point(x: -1, y: 3, z: 10))
        points = [Point(x: -1, y: 5, z: 10),
                  Point(x: -2, y: 7, z: 1),
                  Point(x: -1, y: -1, z: 13),
                  Point(x:  0, y: 3, z: 4),
                  Point(x: -1, y: 12, z: 7)]
        indexes = [2, 4, 1, 0, 4]
        for i in 0..<points.count {
            let index = discreteWorld2D.getIndex(point: points[i])
            XCTAssert( index! == indexes[i] )
        }
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 2, startPoint: Point(x: -1, y: 3, z: 10))
        points = [Point(x: -4, y: 3, z: 10),
                  Point(x:  0, y: 2, z: 1),
                  Point(x:  4, y: 4, z: 13),
                  Point(x:  0, y: 5, z: 4),
                  Point(x:  1, y: 3, z: 7)]
        indexes = [0, 4, 5, 1, 2]
        for i in 0..<points.count {
            let index = discreteWorld2D.getIndex(point: points[i])
            XCTAssert( index! == indexes[i] )
        }
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 1, startPoint: Point(x: -1, y: 3, z: 10))
        points = [Point(x: -4, y: 3, z: 10),
                  Point(x:  0, y: 2, z: 1),
                  Point(x:  4, y: 3, z: 13),
                  Point(x:  0, y: 4, z: 4),
                  Point(x:  1, y: 3, z: 7)]
        indexes = [0, 1, 2, 1, 2]
        for i in 0..<points.count {
            let index = discreteWorld2D.getIndex(point: points[i])
            XCTAssert( index! == indexes[i] )
        }
    }
    
    func testGetFirstNeighbours() {
        var discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 0, verticalSize: 1, startPoint: Point(x: 0, y: 0, z: 0))
        var firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 0)
        XCTAssert( firstNeighbours == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 1, verticalSize: 0, startPoint: Point(x: 0, y: 0, z: 0))
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 0)
        XCTAssert( firstNeighbours == nil )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 1, verticalSize: 1, startPoint: Point(x: 0, y: 0, z: 0))
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 0)
        XCTAssert( firstNeighbours!.isEmpty )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 2, verticalSize: 2, startPoint: Point(x: 0, y: 0, z: 0))
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 0)
        XCTAssert( firstNeighbours!.count == 3 )
        Array<UInt>([ 1, 2, 3]).forEach{ neighbour in firstNeighbours!.removeAll(where: { $0 == neighbour }) }
        XCTAssert( firstNeighbours!.isEmpty )
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 3)
        XCTAssert( firstNeighbours!.count == 3 )
        Array<UInt>([ 0, 1, 2]).forEach{ neighbour in firstNeighbours!.removeAll(where: { $0 == neighbour }) }
        XCTAssert( firstNeighbours!.isEmpty )
        
        discreteWorld2D = DiscreteWorld2D_mock(horizontalSize: 3, verticalSize: 3, startPoint: Point(x: 0, y: 0, z: 0))
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 0)
        XCTAssert( firstNeighbours!.count == 8 )
        Array<UInt>([ 1, 2, 3, 4, 5, 6, 7, 8]).forEach{ neighbour in firstNeighbours!.removeAll(where: { $0 == neighbour }) }
        XCTAssert( firstNeighbours!.isEmpty )
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 3)
        XCTAssert( firstNeighbours!.count == 8 )
        Array<UInt>([ 0, 1, 2, 4, 5, 6, 7, 8]).forEach{ neighbour in firstNeighbours!.removeAll(where: { $0 == neighbour }) }
        XCTAssert( firstNeighbours!.isEmpty )
        firstNeighbours = discreteWorld2D.getFirstNeighbours(index: 8)
        XCTAssert( firstNeighbours!.count == 8 )
        Array<UInt>([ 0, 1, 2, 3, 4, 5, 6, 7]).forEach{ neighbour in firstNeighbours!.removeAll(where: { $0 == neighbour }) }
        XCTAssert( firstNeighbours!.isEmpty )
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
