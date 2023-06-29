//
//  JogoDaVelhaAcademyTests.swift
//  JogoDaVelhaAcademyTests
//
//  Created by Gilberto Magno on 29/06/23.
//

import XCTest
@testable import JogoDaVelhaAcademy


final class JogoDaVelhaAcademyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_GranyViewModel_checkIfHasVictory_X() {
        var viewmodel: GrannyViewModel = GrannyViewModel()
        viewmodel.board = [[.X,.none,.X],
                           [.none,.X,.none],
                           [.X,.none,.none]]
        let actualResult = viewmodel.checkIfHasVictory()
        let expectedResult: Marker = .X
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func test_CheckersResult_checkIfHasVictory() {
        let board: [[Marker]] = [[.X,.none,.X],
                                 [.none,.X,.none],
                                 [.X,.none,.none]]

        let expected: Marker = .X
        let actual = CheckersResult.checkIfHasVictory(board)
        XCTAssertEqual(expected, actual)
        
    }

    func test_theMatchEndedBegun() throws {
        var viewmodel: GrannyViewModel = GrannyViewModel()
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
