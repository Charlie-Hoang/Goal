//
//  Date+ExtTest.swift
//  GoalTests
//
//  Created by Charlie Hoang on 11/23/22.
//

import XCTest
import Goal

class Date_ExtTest: XCTestCase {

    func testGToDateString(){
        let dateString = "2022-04-24T18:00:00.000Z"
        let input = dateString.gToDate()
        let output = input?.gToDateString()
        let expectation = "2022-04-24"
        XCTAssertEqual(output, expectation, "should be equal!")
    }
    func testGToTimeString(){
        let dateString = "2022-04-24T18:00:00.000Z"
        let input = dateString.gToDate()
        let output = input?.gToTimeString()
        let expectation = "18:00:00"
        XCTAssertEqual(output, expectation, "should be equal!")
    }
}
